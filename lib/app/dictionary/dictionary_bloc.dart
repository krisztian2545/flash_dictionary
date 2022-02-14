import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/definition_api_service.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flash_dictionary/service/translation_api_service.dart';
import 'package:flutter/material.dart';

class DictionaryBloc extends ChangeNotifier {
  DictionaryBloc(
      {this.fromLanguage = LanguageName.eng,
      this.toLanguage = LanguageName.hun,
      this.translationApi = TranslationApi.linkDictionary,
      this.definitionApi = DefinitionApi.wordsApi})
      : translationService = TranslationApiService.getApi(translationApi),
        definitionApiService = DefinitionApiService.getApi(definitionApi);

  String _wordToTranslate = "";

  String get wordToTranslate => _wordToTranslate;

  set wordToTranslate(String value) {
    _wordToTranslate = value;
    notifyListeners();
  }

  LanguageName fromLanguage; // TODO: value notifieres for the buttons
  LanguageName toLanguage;
  TranslationApi translationApi;
  DefinitionApi definitionApi;

  TranslationApiService translationService;
  DefinitionApiService definitionApiService;

  Future<Map<String, dynamic>> fetchData() async {
    var definitions = await definitionApiService.getDefinition(
        wordToTranslate, fromLanguage);
    var translations = await translationService.getTranslations(
        wordToTranslate, fromLanguage, toLanguage);
    return {
      'translations': translations,
      'definitions': definitions,
    };
  }
}
