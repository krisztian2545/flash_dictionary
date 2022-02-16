import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/translation_api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HBoxName {
  static const history = "history";
}

class BoxKey {
  static const wordHistory = "wordHistory";
  static const lastUsedFromLanguage = "lastUsedFromLanguage";
  static const lastUsedToLanguage = "lastUsedToLanguage";
}

class HiveHelper {

  static late Box _historyBox;

  static Future<void> initAndOpenBoxes() async {
    await Hive.initFlutter();
    _historyBox = await Hive.openBox(HBoxName.history);
  }

  static void saveWordInHistory(String word, LanguageName from, LanguageName to, TranslationApi api) {
    if (word == "") {
      return;
    }

    var wordHistory = getWordHistory();
    var compressedData = "$word;${from.value}-${to.value};${api.value}";

    if (wordHistory.contains(compressedData))  {
      return;
    }

    wordHistory.add(compressedData);
    _historyBox.put(BoxKey.wordHistory, wordHistory);
  }

  static List<String> getWordHistory() {
    return _historyBox.get(BoxKey.wordHistory, defaultValue: <String>[]);
  }

  static void saveAsLastUsedFromLanguage(LanguageName lang) {
    _historyBox.put(BoxKey.lastUsedFromLanguage, lang.value);
  }

  static LanguageName getLastUsedFromLanguage() {
    return _historyBox.get(BoxKey.lastUsedFromLanguage, defaultValue: LanguageName.eng);
  }

  static void saveAsLastUsedToLanguage(LanguageName lang) {
    _historyBox.put(BoxKey.lastUsedToLanguage, lang.value);
  }

  static LanguageName getLastUsedToLanguage() {
    return _historyBox.get(BoxKey.lastUsedToLanguage, defaultValue: LanguageName.hun);
  }

}