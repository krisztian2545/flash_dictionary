import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/service/definition_api_service.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flash_dictionary/service/translation_api_service.dart';
import 'package:flutter/material.dart';

class DictionaryBloc extends ChangeNotifier {
  DictionaryBloc(
      {LanguageName? fromLanguage,
      LanguageName? toLanguage,
      this.translationApi =
          TranslationApi.linkDictionary, // TODO save and get last apis too
      this.definitionApi = DefinitionApi.wordsApi}) {
    translationService = TranslationApiService.getApi(translationApi);
    definitionApiService = DefinitionApiService.getApi(definitionApi);
    _fromLanguage = fromLanguage ?? HiveHelper.getLastUsedFromLanguage();
    _toLanguage = toLanguage ?? HiveHelper.getLastUsedToLanguage();
  }

  String _wordToTranslate = "";

  String get wordToTranslate => _wordToTranslate;

  set wordToTranslate(String value) {
    // TODO make it a func and ask if to store
    _wordToTranslate = value;
    notifyListeners();
  }

  late LanguageName _fromLanguage;

  LanguageName get fromLanguage => _fromLanguage;

  set fromLanguage(LanguageName value) {
    HiveHelper.saveAsLastUsedFromLanguage(value);
    if (value == toLanguage) {
      switchLanguages();
      return;
    }
    _fromLanguage = value;
    notifyListeners();
  }

  late LanguageName _toLanguage;

  LanguageName get toLanguage => _toLanguage;

  set toLanguage(LanguageName value) {
    HiveHelper.saveAsLastUsedToLanguage(value);
    if (value == fromLanguage) {
      switchLanguages();
      return;
    }
    _toLanguage = value;
    notifyListeners();
  }

  TranslationApi translationApi;
  DefinitionApi definitionApi;

  late TranslationApiService translationService;
  late DefinitionApiService definitionApiService;

  List<DefinitionItem>? lastFetchedDefinitions;
  List<TranslationItem>? lastFetchedTranslationItems;

  void switchLanguages() {
    var temp = _fromLanguage;
    _fromLanguage = _toLanguage;
    _toLanguage = temp;
    HiveHelper.saveAsLastUsedFromLanguage(_fromLanguage);
    HiveHelper.saveAsLastUsedToLanguage(_toLanguage);
    notifyListeners();
  }

  void setWordAndLanguages(String word, LanguageName from, LanguageName to) {
    _fromLanguage = from;
    _toLanguage = to;
    HiveHelper.saveAsLastUsedFromLanguage(_fromLanguage);
    HiveHelper.saveAsLastUsedToLanguage(_toLanguage);
    wordToTranslate = word;
  }

  Future<Map<String, dynamic>> fetchData([String? word, LanguageName? from, LanguageName? to]) async {
    String w = word ?? wordToTranslate;
    LanguageName fromL = from ?? fromLanguage;
    LanguageName toL = to ?? toLanguage;

    lastFetchedDefinitions =
        await definitionApiService.getDefinition(w, fromL);
    lastFetchedTranslationItems = await translationService.getTranslations(
        w, fromL, toL);
    return {
      'translations': lastFetchedTranslationItems,
      'definitions': lastFetchedDefinitions,
    };
  }

  void saveWordToCollection(CollectionDetails collection, LanguageCard languageCard) {
    HiveHelper.saveLanguageCardToCollection(collection, languageCard);
  }
}
