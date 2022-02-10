import 'dart:convert';

import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flash_dictionary/service/api_service.dart';
import 'package:http/http.dart' as http;

class LinkDictionaryApi implements ApiService {

  static const Map<LanguageNames, String> languageStringName = {
    LanguageNames.eng: 'eng',
    LanguageNames.hun: 'hun',
  };

  static List<TranslationItem> translationItemListFormJson(json) =>
      (json['results'] as List)
          .map((e) => TranslationItem(word: e['word']))
          .toList();

  @override
  Future<List<TranslationItem>> getTranslations(String word, LanguageNames from, LanguageNames to) async {
    http.Response res = await http.get(
        Uri.parse(
            "https://link-bilingual-dictionary.p.rapidapi.com/${languageStringName[from]}/${languageStringName[to]}/${word}"),
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