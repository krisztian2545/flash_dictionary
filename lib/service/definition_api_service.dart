import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/definition_api_implementations/wrods_api.dart';

enum DefinitionApi {
  wordsApi
}

abstract class DefinitionApiService {
  Future<List<DefinitionItem>> getDefinition(String word, LanguageName lang);

  static DefinitionApiService getApi(DefinitionApi api) {
    switch (api) {
      case DefinitionApi.wordsApi:
      default:
        return WordsApi();
    }
  }
}