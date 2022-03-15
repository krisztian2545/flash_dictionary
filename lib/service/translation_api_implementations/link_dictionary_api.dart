import 'dart:convert';

import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flash_dictionary/service/translation_api_service.dart';
import 'package:http/http.dart' as http;

class LinkDictionaryApi implements TranslationApiService {

  // static const Map<LanguageName, String> languageStringName = {
  //   LanguageName.eng: 'eng',
  //   LanguageName.hun: 'hun',
  // };

  static List<TranslationItem> translationItemListFormJson(parsedJson) =>
      (parsedJson['results'] as List)
          .map((e) => TranslationItem(word: e['word']))
          .toList();

  @override
  Future<List<TranslationItem>> getTranslations(String word, LanguageName from, LanguageName to) async {
    http.Response res = await http.get(
        Uri.parse(
            "https://link-bilingual-dictionary.p.rapidapi.com/${from.name}/${to.name}/${word}"),
        headers: {
          "x-rapidapi-key":
          "ce00069c30msh4cb29af9cfca0f7p1a3af7jsn38922cb7f89a",
          "x-rapidapi-host": "link-bilingual-dictionary.p.rapidapi.com",
          "useQueryString": "true",
        });

    print("translation status code: ${res.statusCode} body: ${res.body}");

    return translationItemListFormJson(jsonDecode(res.body));
  }


}