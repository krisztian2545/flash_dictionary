import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
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
  List<TranslationItem>? lastFetchedTranslationItem;

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

  Future<Map<String, dynamic>> fetchData() async {
    lastFetchedDefinitions =
        await definitionApiService.getDefinition(wordToTranslate, fromLanguage);
    lastFetchedTranslationItem = await translationService.getTranslations(
        wordToTranslate, fromLanguage, toLanguage);
    return {
      'translations': lastFetchedTranslationItem,
      'definitions': lastFetchedDefinitions,
    };
  }
}
