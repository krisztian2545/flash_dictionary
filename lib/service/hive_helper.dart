import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/domain/minigame/card_values.dart';
import 'package:flash_dictionary/domain/minigame/game_card.dart';
import 'package:flash_dictionary/service/translation_api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';

class HBoxName {
  static const history = "history";
  static const collectionList = "collectionList";
}

class BoxKey {
  static const wordHistory = "wordHistory";
  static const lastUsedFromLanguage = "lastUsedFromLanguage";
  static const lastUsedToLanguage = "lastUsedToLanguage";
  static const lastUsedCollectionIndex = "lastUsedCollectionIndex";

  static String cardValuesBoxNameFromCollection(CollectionDetails collection) =>
      "cardValuesOf" + collection.getStringId();
}

class HiveHelper {
  static late Box _historyBox;
  static late Box _collectionListBox;

  /// returns null if value not found
  static dynamic findKeyOfValue(Map map, value) {
    for (var entry in map.entries) {
      print("findKeyOfValue: ${entry.value} == ${value}");
      if (value is Map) {
        if (DeepCollectionEquality().equals(entry.value, value)) {
          print("entry.key");
          return entry.key;
        }
      } else if (entry.value == value) {
        print("entry.key");
        return entry.key;
      }
    }
  }

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
      return collectionList[
          _historyBox.get(BoxKey.lastUsedCollectionIndex, defaultValue: 0)];
    } on Exception {
      return collectionList[0];
    }
  }

  static void deleteCollection(CollectionDetails collectionDetails) {
    var mappedCollection = collectionDetails.toMap();
    var key = findKeyOfValue(_collectionListBox.toMap(), mappedCollection);
    print("deleteng at key: $key");
    if (key == null) {
      return;
    }
    _collectionListBox.delete(key);
    Hive.deleteBoxFromDisk(collectionDetails.getStringId());
  }

  static Future<void> saveLanguageCardToCollection(
      CollectionDetails collection, LanguageCard languageCard) async {
    Box collectionBox = await Hive.openBox(collection.getStringId());
    collectionBox.add(languageCard.toMap());
  }

  static Future<void> updateLanguageCardInCollection(
      CollectionDetails collection,
      LanguageCard oldValue,
      LanguageCard newValue) async {
    Box collectionBox = await Hive.openBox(collection.getStringId());
    var key = findKeyOfValue(collectionBox.toMap(), oldValue.toMap());
    if (key == null) {
      return;
    }
    collectionBox.put(key, newValue.toMap());
  }

  static Future<List<LanguageCard>> getLanguageCardsFromCollection(
      CollectionDetails collection) async {
    Box collectionBox = await Hive.openBox(collection.getStringId());

    return collectionBox.values.map((e) => LanguageCard.fromMap(e)).toList();
  }

  static Future<void> deleteLanguageCardFromCollection(
      CollectionDetails collectionDetails, LanguageCard languageCard) async {
    Box collectionBox = await Hive.openBox(collectionDetails.getStringId());
    var key = findKeyOfValue(collectionBox.toMap(), languageCard.toMap());
    if (key == null) {
      return;
    }

    collectionBox.delete(key);
  }

  static Future<List<GameCard>> getGameCardsFromCollection(
      CollectionDetails collection) async {
    Box cardValuesBox =
        await Hive.openBox(BoxKey.cardValuesBoxNameFromCollection(collection));
    List<LanguageCard> cards = await getLanguageCardsFromCollection(collection);

    cardValuesBox.values.forEach(print);

    List<GameCard> gameCards = <GameCard>[];
    for (var card in cards) {
      gameCards.add(GameCard(
          card,
          CardValues.fromMap(cardValuesBox.values
                  .firstWhereOrNull((e) {
                    print("${e['front']} == ${card.front}");
            return e['front'] == card.front;
          })) ??
              CardValues.zero));
    }

    return gameCards;
  }

  static Future<void> saveGameCardList(
      CollectionDetails collection, List<GameCard> gameCards) async {
    Box cardValuesBox =
        await Hive.openBox(BoxKey.cardValuesBoxNameFromCollection(collection));

    await cardValuesBox.clear();
    await cardValuesBox.addAll(gameCards.map((e) =>
        CardValues(e.values.confidenceValue, e.values.lastGameValue)
            .toMap(e.card.front)));
  }
}
