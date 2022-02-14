import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/translation_api_service.dart';
import 'package:hive/hive.dart';

class HBoxName {
  static const history = "history";
}

class HiveHelper {

  static void saveWordInHistory(String word, LanguageName from, LanguageName to, TranslationApi api) {
    var wordHistory = getWordHistory();
    var compressedData = "$word;${from.value}-${to.value};${api.value}";

    if (wordHistory.contains(compressedData))  {
      return;
    }

    wordHistory.add(compressedData);
    Hive.box(HBoxName.history).put('wordHistory', wordHistory);
  }

  static List<String> getWordHistory() {
    return Hive.box(HBoxName.history).get('wordHistory', defaultValue: <String>[]);
  }

}