import 'dart:math';

import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/minigame/game_card.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';

enum CardDifficulty { easy, medium, hard }

class MinigameBloc extends ChangeNotifier {
  MinigameBloc(
      {required this.collectionDetails, required List<GameCard> gameCards}) {
    for (var card in gameCards) {
      cardsByConfidenceValue[card.values.confidenceValue] ??= <GameCard>[];
      cardsByConfidenceValue[card.values.confidenceValue]?.add(card);
    }
  }

  static const _perGameScoreNeeded = 5;

  final CollectionDetails collectionDetails;

  // final List<GameCard> _gameCards;
  final List<GameCard> learnedGameCards = <GameCard>[];
  final Map<int, List<GameCard>> cardsByConfidenceValue =
      <int, List<GameCard>>{};

  late GameCard _currentGameCard;

  GameCard get currentGameCard => _currentGameCard;

  late int smallestConfidenceValue;

  final _random = Random();

  /// Returns false if game over
  bool pickRandomCard() {
    print("cardsByConfidenceValue: $cardsByConfidenceValue");

    if (cardsByConfidenceValue.keys.isEmpty) {
      // game over
      for (var card in learnedGameCards) {
        card.values.confidenceValue = card.values.lastGameValue;
        card.values.lastGameValue = 0;
      }

      return false;
    }

    smallestConfidenceValue = cardsByConfidenceValue.keys.reduce(
        (smallest, current) => (current < smallest) ? current : smallest);

    _currentGameCard = cardsByConfidenceValue[smallestConfidenceValue]![_random
        .nextInt(cardsByConfidenceValue[smallestConfidenceValue]!.length)];
    return true;
  }

  void removeCurrentCardFromMap() {
    cardsByConfidenceValue[smallestConfidenceValue]?.remove(_currentGameCard);
    if (cardsByConfidenceValue[smallestConfidenceValue]!.isEmpty) {
      cardsByConfidenceValue.remove(smallestConfidenceValue);
    }
  }

  void giveFeedback(CardDifficulty difficulty) {
    print("feedback: $difficulty");
    switch (difficulty) {
      case CardDifficulty.easy:
        _currentGameCard.values.lastGameValue += 4;
        break;
      case CardDifficulty.medium:
        _currentGameCard.values.lastGameValue += 3;
        break;
      case CardDifficulty.hard:
        _currentGameCard.values.lastGameValue += 1;
        break;
    }

    if (_currentGameCard.values.lastGameValue >= _perGameScoreNeeded) {

      removeCurrentCardFromMap();
      learnedGameCards.add(_currentGameCard);
    } else {

      removeCurrentCardFromMap();
      cardsByConfidenceValue[_currentGameCard.values.lastGameValue] ??= <GameCard>[];
      cardsByConfidenceValue[_currentGameCard.values.lastGameValue]?.add(_currentGameCard);
    }

    notifyListeners();
  }

  void saveData() {
    print("saving cards...");
    List<GameCard> allCards = <GameCard>[];
    allCards.addAll(learnedGameCards);

    for (var cardList in cardsByConfidenceValue.values) {
      allCards.addAll(cardList);
    }

    HiveHelper.saveGameCardList(collectionDetails, allCards);
  }
}
