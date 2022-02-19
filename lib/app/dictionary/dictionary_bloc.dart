import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/definition_api_service.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flash_dictionary/service/translation_api_service.dart';
import 'package:flutter/material.dart';

class DictionaryBloc extends ChangeNotifier {
  DictionaryBloc(
      {LanguageName fromLanguage = LanguageName.eng,
      LanguageName toLanguage = LanguageName.hun,
      this.translationApi = TranslationApi.linkDictionary,
      this.definitionApi = DefinitionApi.wordsApi})
      : translationService = TranslationApiService.getApi(translationApi),
        definitionApiService = DefinitionApiService.getApi(definitionApi),
        _fromLanguage = fromLanguage,
        _toLanguage = toLanguage;

  String _wordToTranslate = "";

  String get wordToTranslate => _wordToTranslate;

  set wordToTranslate(String value) {
    // TODO make it a func and ask if to store
    _wordToTranslate = value;
    notifyListeners();
  }

  LanguageName _fromLanguage;

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

  LanguageName _toLanguage;

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

  TranslationApiService translationService;
  DefinitionApiService definitionApiService;

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
    wordToTranslate = word;
  }

  Future<Map<String, dynamic>> fetchData() async {
    var definitions =
        await definitionApiService.getDefinition(wordToTranslate, fromLanguage);
    var translations = await translationService.getTranslations(
        wordToTranslate, fromLanguage, toLanguage);
    return {
      'translations': translations,
      'definitions': definitions,
    };
  }
}
