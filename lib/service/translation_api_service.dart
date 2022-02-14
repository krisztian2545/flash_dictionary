import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flash_dictionary/service/translation_api_implementations/link_dictionary_api.dart';

enum TranslationApi {
  linkDictionary
}

extension TranslationApiExtension on TranslationApi {
  String get value {
    switch (this) {

      case TranslationApi.linkDictionary:
        return "linkD";
    }
  }
}

abstract class TranslationApiService {

  Future<List<TranslationItem>> getTranslations(String word, LanguageName from, LanguageName to);

  static TranslationApiService getApi(TranslationApi? api) {
    switch(api) {
      case TranslationApi.linkDictionary:
      default:
        return LinkDictionaryApi();
    }
  }

}

