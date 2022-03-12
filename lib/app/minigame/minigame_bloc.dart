import 'dart:math';

import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/minigame/game_card.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';

enum CardDifficulty { easy, medium, hard }

class MinigameBloc extends ChangeNotifier {
  MinigameBloc(
      {required this.collectionDetails, required List<GameCard> gameCards}) {
    if (gameCards.any((card) => card.values.lastGameValue > 0)) {
      // continue last game
      for (var card in gameCards) {
        if (card.values.lastGameValue >= _perGameScoreNeeded) {
          learnedGameCards.add(card);
          continue;
        }
        cardsByConfidenceValue[card.values.lastGameValue] ??= <GameCard>[];
        cardsByConfidenceValue[card.values.lastGameValue]?.add(card);
      }
      return;
    }

    // new game
    int smallestValue = gameCards
        .reduce((smallest, current) =>
            (current.values.confidenceValue < smallest.values.confidenceValue)
                ? current
                : smallest)
        .values
        .confidenceValue;

    for (var card in gameCards) {
      card.values.lastGameValue = card.values.confidenceValue - smallestValue;
      card.values.confidenceValue = 0;

      cardsByConfidenceValue[card.values.lastGameValue] ??= <GameCard>[];
      cardsByConfidenceValue[card.values.lastGameValue]?.add(card);
    }
  }

  static const _perGameScoreNeeded = 5;
  static const _easyConfiedenceValue = 4;
  static const _mediumConfidenceValue = 3;
  static const _hardConfidenceValue = 1;

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
        _currentGameCard.values.lastGameValue += _easyConfiedenceValue;
        break;
      case CardDifficulty.medium:
        _currentGameCard.values.lastGameValue += _mediumConfidenceValue;
        break;
      case CardDifficulty.hard:
        _currentGameCard.values.lastGameValue += _hardConfidenceValue;
        break;
    }

    if (_currentGameCard.values.lastGameValue >= _perGameScoreNeeded) {
      removeCurrentCardFromMap();
      learnedGameCards.add(_currentGameCard);
    } else {
      removeCurrentCardFromMap();
      cardsByConfidenceValue[_currentGameCard.values.lastGameValue] ??=
          <GameCard>[];
      cardsByConfidenceValue[_currentGameCard.values.lastGameValue]
          ?.add(_currentGameCard);
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
