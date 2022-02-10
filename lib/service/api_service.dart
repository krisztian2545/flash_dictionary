import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flash_dictionary/service/api_implementations/link_dictionary_api.dart';

enum TranslationApi {
  linkDictionary
}

abstract class ApiService {

  Future<List<TranslationItem>> getTranslations(String word, LanguageNames from, LanguageNames to);

  static ApiService getApi(TranslationApi? api) {
    switch(api) {
      case TranslationApi.linkDictionary:
      default:
        return LinkDictionaryApi();
    }
  }

}

