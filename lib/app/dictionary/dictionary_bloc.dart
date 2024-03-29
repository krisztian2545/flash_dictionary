import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/domain/dictionary/word_with_params.dart';
import 'package:flash_dictionary/service/definition_api_service.dart';
import 'package:flash_dictionary/service/storage_service.dart';
import 'package:flash_dictionary/service/translation_api_service.dart';
import 'package:flutter/material.dart';

class DictionaryBloc extends ChangeNotifier {
  DictionaryBloc(
      {LanguageName? fromLanguage,
      LanguageName? toLanguage,
      this.translationApi =
          TranslationApi.linkDictionary, // TODO save and get last apis too
      this.definitionApi = DefinitionApi.wordsApi}) {
    translationApiService = TranslationApiService.getApi(translationApi);
    definitionApiService = DefinitionApiService.getApi(definitionApi);
    _fromLanguage = fromLanguage ?? StorageService.getLastUsedFromLanguage();
    _toLanguage = toLanguage ?? StorageService.getLastUsedToLanguage();
  }

  String _wordToTranslate = "";

  String get wordToTranslate => _wordToTranslate;

  late LanguageName __fromLanguage;

  LanguageName get fromLanguage => __fromLanguage;

  set _fromLanguage(LanguageName value) {
    StorageService.saveAsLastUsedFromLanguage(value);
    __fromLanguage = value;
  }

  void switchFromLanguageTo(LanguageName lang) {
    if (lang == toLanguage) { // TODO maybe dont switch languages, so it can work like a synonym dictionary too with this api, but beware of coollections
      _toLanguage = fromLanguage;
    }
    _fromLanguage = lang;
    notifyListeners();
  }

  late LanguageName __toLanguage;

  LanguageName get toLanguage => __toLanguage;

  set _toLanguage(LanguageName value) {
    StorageService.saveAsLastUsedToLanguage(value);
    __toLanguage = value;
  }

  void switchToLanguageTo(LanguageName lang) {
    if (lang == fromLanguage) {
      _fromLanguage = toLanguage;
    }
    _toLanguage = lang;
    notifyListeners();
  }

  TranslationApi translationApi;
  DefinitionApi definitionApi;

  late TranslationApiService translationApiService;
  late DefinitionApiService definitionApiService;

  List<DefinitionItem>? lastFetchedDefinitions;
  List<TranslationItem>? lastFetchedTranslationItems;

  void clearText() {
    _wordToTranslate = "";
    notifyListeners();
  }

  void searchForWord(String word) {
    _wordToTranslate = word;
    StorageService.saveWordInHistory(
        WordWithParams(wordToTranslate, fromLanguage, toLanguage));
    notifyListeners();
  }

  void searchForWordWithParams(
      String word, LanguageName from, LanguageName to) {
    _fromLanguage = from;
    _toLanguage = to;

    searchForWord(word);
  }

  Future<Map<String, dynamic>> fetchData() async {
    // TODO don't fetch definitions if fromLanguage didn't change
    lastFetchedDefinitions =
        await definitionApiService.getDefinition(wordToTranslate, fromLanguage);
    lastFetchedTranslationItems = await translationApiService.getTranslations(
        wordToTranslate, fromLanguage, toLanguage);
    return {
      'translations': lastFetchedTranslationItems,
      'definitions': lastFetchedDefinitions,
    };
  }

  Future<Map<String, dynamic>> fetchDataWithParams(
      String word, LanguageName from, LanguageName to) async {
    _wordToTranslate = word;
    _fromLanguage = from;
    _toLanguage = to;

    return await fetchData();
  }

  void saveWordToCollection(
      CollectionDetails collection, LanguageCard languageCard) {
    StorageService.saveLanguageCardToCollection(collection, languageCard);
  }

  List<WordWithParams> getWordHistory() => StorageService.getWordHistory();
}
