import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/api_service.dart';
import 'package:flutter/material.dart';

class DictionaryBloc extends ChangeNotifier {

  DictionaryBloc(
      {this.languageFrom = LanguageNames.hun, this.languageTo = LanguageNames
          .eng, this.translationApi = TranslationApi.linkDictionary})
      : translationService = ApiService.getApi(translationApi);

  String _wordToTranslate = "";

  String get wordToTranslate => _wordToTranslate;

  set wordToTranslate(String value) {
    _wordToTranslate = value;
    notifyListeners();
  }

  LanguageNames languageFrom; // TODO: value notifieres for the buttons
  LanguageNames languageTo;
  TranslationApi translationApi;

  ApiService translationService;


  Future<Map<String, dynamic>> fetchData() async {
    return {"translations": await translationService.getTranslations(wordToTranslate, languageFrom, languageTo)};
  }

}