import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/minigame/language_card.dart';
import 'package:flash_dictionary/service/translation_api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HBoxName {
  static const history = "history";
  static const collectionList = "collectionList";
}

class BoxKey {
  static const wordHistory = "wordHistory";
  static const lastUsedFromLanguage = "lastUsedFromLanguage";
  static const lastUsedToLanguage = "lastUsedToLanguage";
  static const lastUsedCollectionIndex = "lastUsedCollectionIndex";
}

class HiveHelper {
  static late Box _historyBox;
  static late Box _collectionListBox;

  static Future<void> initAndOpenBoxes() async {
    await Hive.initFlutter();
    _historyBox = await Hive.openBox(HBoxName.history);
    _collectionListBox = await Hive.openBox(HBoxName.collectionList);
  }

  static void saveWordInHistory(
      String word, LanguageName from, LanguageName to, TranslationApi api) {
    if (word == "") {
      return;
    }

    var wordHistory = getWordHistory();
    var compressedData = "$word;${from.value}-${to.value};${api.value}";

    if (wordHistory.contains(compressedData)) {
      return;
    }

    wordHistory.add(compressedData);
    _historyBox.put(BoxKey.wordHistory, wordHistory);
  }

  static List<String> getWordHistory() =>
      _historyBox.get(BoxKey.wordHistory, defaultValue: <String>[]);

  static void saveAsLastUsedFromLanguage(LanguageName lang) =>
      _historyBox.put(BoxKey.lastUsedFromLanguage, lang.value);

  static LanguageName getLastUsedFromLanguage() =>
      languageNameFromString(_historyBox.get(BoxKey.lastUsedFromLanguage,
          defaultValue: LanguageName.eng.value));

  static void saveAsLastUsedToLanguage(LanguageName lang) =>
      _historyBox.put(BoxKey.lastUsedToLanguage, lang.value);

  static LanguageName getLastUsedToLanguage() =>
      languageNameFromString(_historyBox.get(BoxKey.lastUsedToLanguage,
          defaultValue: LanguageName.hun.value));

  static void saveCollectionDetails(CollectionDetails collectionDetails) {
    _collectionListBox.add(collectionDetails.toMap());
    // Hive.openBox(collectionDetails.getStringId());
  }

  static List<CollectionDetails> getCollectionList() =>
      _collectionListBox.values
          .map((e) => CollectionDetails.fromMap(e))
          .toList();

  static saveAsLastUsedCollection(CollectionDetails collectionDetails) {
    var index = getCollectionList().indexOf(collectionDetails);
    if (index > 0) {
      _historyBox.put(BoxKey.lastUsedCollectionIndex, index);
    }
  }

  static CollectionDetails? getLastUsedCollection() {
    var collectionList = getCollectionList();
    if (collectionList.isEmpty) {
      return null;
    }

    try {
      return collectionList[_historyBox.get(BoxKey.lastUsedCollectionIndex, defaultValue: 0)];
    }
    on Exception {
      return collectionList[0];
    }
  }
  
  static Future<void> saveLanguageCardToCollection(CollectionDetails collection, LanguageCard languageCard) async {
    Box collectionBox = await Hive.openBox(collection.getStringId());
    collectionBox.put(languageCard.front, languageCard.back);
  }

  static Future<List<LanguageCard>> getLanguageCardsFromCollection(CollectionDetails collection) async {
    Box collectionBox = await Hive.openBox(collection.getStringId());
    var languageCardList = <LanguageCard>[];
    var keys = collectionBox.keys.toList();
    var values = collectionBox.values.toList();

    for (int i = 0; i < collectionBox.length; i++) {
      languageCardList.add(LanguageCard(front: keys[i], back: values[i]));
    }

    return languageCardList;
  }
}
