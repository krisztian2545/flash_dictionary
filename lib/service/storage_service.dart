import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/domain/dictionary/word_with_params.dart';
import 'package:flash_dictionary/domain/minigame/card_values.dart';
import 'package:flash_dictionary/domain/minigame/game_card.dart';
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
  static const lastShowDefinitionsState = "lastShowDefinitionsState";
  static const lastShowTranslationsState = "lastShowTranslationsState";
  static const lastUsedCollectionIndex = "lastUsedCollectionIndex";

  static String cardValuesBoxNameFromCollection(CollectionDetails collection) =>
      "cardValuesOf" + collection.getStringId();
}

class StorageService {
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

    Hive.registerAdapter(WordWithParamsAdapter());
    Hive.registerAdapter(LanguageNameAdapter());

    _historyBox = await Hive.openBox(HBoxName.history);
    _collectionListBox = await Hive.openBox(HBoxName.collectionList);
  }

  static void saveWordInHistory(WordWithParams wordWithParams) {
    if (wordWithParams.word == "") {
      return;
    }

    var wordHistory = getWordHistory();
    var compressedData = wordWithParams;

    if (wordHistory.contains(compressedData)) {
      wordHistory.remove(compressedData);
    }

    // TODO limit history size / add ability to clear
    wordHistory.add(compressedData);
    _historyBox.put(BoxKey.wordHistory, wordHistory);
  }

  static List<WordWithParams> getWordHistory() =>
      (_historyBox.get(BoxKey.wordHistory, defaultValue: <WordWithParams>[])
              as List)
          .map((e) => e as WordWithParams)
          .toList()
          .reversed
          .toList();

  static void saveAsLastUsedFromLanguage(LanguageName lang) =>
      _historyBox.put(BoxKey.lastUsedFromLanguage, lang.name);

  static LanguageName getLastUsedFromLanguage() =>
      languageNameFromString(_historyBox.get(BoxKey.lastUsedFromLanguage,
          defaultValue: LanguageName.eng.name));

  static void saveAsLastUsedToLanguage(LanguageName lang) =>
      _historyBox.put(BoxKey.lastUsedToLanguage, lang.name);

  static LanguageName getLastUsedToLanguage() =>
      languageNameFromString(_historyBox.get(BoxKey.lastUsedToLanguage,
          defaultValue: LanguageName.hun.name));

  static void saveLastShowDefinitionsState(bool value) =>
      _historyBox.put(BoxKey.lastShowDefinitionsState, value);

  static bool getLastShowDefinitionsState() =>
      _historyBox.get(BoxKey.lastShowDefinitionsState, defaultValue: true);

  static void saveLastShowTranslationsState(bool value) =>
      _historyBox.put(BoxKey.lastShowTranslationsState, value);

  static bool getLastShowTranslationsState() =>
      _historyBox.get(BoxKey.lastShowTranslationsState, defaultValue: true);

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
          CardValues.fromMap(cardValuesBox.values.firstWhereOrNull((e) {
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
