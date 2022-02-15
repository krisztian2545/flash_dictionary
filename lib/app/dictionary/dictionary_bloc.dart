import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/definition_api_service.dart';
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
    // if (value == _toLanguage) {
    //   _toLanguage = _fromLanguage;
    // }

    _fromLanguage = value;
  }

  LanguageName _toLanguage;

  LanguageName get toLanguage => _toLanguage;

  set toLanguage(LanguageName value) {
    // if (value == _fromLanguage) {
    //   _fromLanguage = _toLanguage;
    // }

    _toLanguage = value;
  }

  void switchLanguages() {
    var temp = _fromLanguage;
    _fromLanguage = _toLanguage;
    _toLanguage = temp;
  }


  TranslationApi translationApi;
  DefinitionApi definitionApi;

  TranslationApiService translationService;
  DefinitionApiService definitionApiService;

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
