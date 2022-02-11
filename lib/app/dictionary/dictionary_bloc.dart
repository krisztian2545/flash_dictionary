import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/definition_api_service.dart';
import 'package:flash_dictionary/service/translation_api_service.dart';
import 'package:flutter/material.dart';

class DictionaryBloc extends ChangeNotifier {
  DictionaryBloc(
      {this.languageFrom = LanguageNames.eng,
      this.languageTo = LanguageNames.hun,
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

  LanguageNames languageFrom; // TODO: value notifieres for the buttons
  LanguageNames languageTo;
  TranslationApi translationApi;
  DefinitionApi definitionApi;

  TranslationApiService translationService;
  DefinitionApiService definitionApiService;

  Future<Map<String, dynamic>> fetchData() async {
    var definitions = await definitionApiService.getDefinition(
        wordToTranslate, languageFrom);
    var translations = await translationService.getTranslations(
        wordToTranslate, languageFrom, languageTo);
    return {
      'translations': translations,
      'definitions': definitions,
    };
  }
}
