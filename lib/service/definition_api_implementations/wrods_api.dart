import 'dart:convert';

import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/definition_api_service.dart';
import 'package:http/http.dart' as http;

class WordsApi implements DefinitionApiService {
  static List<DefinitionItem> definitionItemListFromJson(String source) {
    var parsedJson = jsonDecode(source);
    print("// successfully parsed");

    if (parsedJson['results'] == null) {
      print("returning empty list");
      return <DefinitionItem>[];
    }

    return (parsedJson['results'] as List).map((e) {
      // ((e['examples'] ?? []) as List).forEach((element) {
      //   print("element: ${element as String}");
      // });
      var temp = DefinitionItem(
          (e['definition'] ?? "") as String,
          (e['partOfSpeech'] ?? "") as String,
          ((e['examples'] ?? []) as List).map((e) => e as String).toList());
      // print(
      //     "Def item: ${temp.defintion} ${temp.partOfSpeech} ${temp.examples}");
      return temp;
    }).toList();
  }

  @override
  Future<List<DefinitionItem>> getDefinition(
      String word, LanguageName lang) async {
    http.Response res = await http.get(
        Uri.parse("https://wordsapiv1.p.rapidapi.com/words/$word"),
        headers: {
          'x-rapidapi-host': 'wordsapiv1.p.rapidapi.com',
          'x-rapidapi-key': '21a76374f9msh3055b2e33997171p14398ajsn790a754550cd'
        });
    print("definition status code: ${res.statusCode} body: ${res.body}");

    return definitionItemListFromJson(res.body);
  }
}
