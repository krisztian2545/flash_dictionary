import 'dart:math';

import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/minigame/game_card.dart';
import 'package:flutter/material.dart';

enum CardDifficulty {
  easy, medium, hard
}

class MinigameBloc extends ChangeNotifier {
  MinigameBloc({required this.collectionDetails, required this.gameCards});

  final CollectionDetails collectionDetails;
  final List<GameCard> gameCards;

  late GameCard _currentGameCard;
  GameCard get currentGameCard => _currentGameCard;

  final _random = Random();

  void pickRandomCard() {
    // TODO pick based on confidence values
    _currentGameCard = gameCards[_random.nextInt(gameCards.length)];
  }

  void giveFeedback(CardDifficulty difficulty) {
    print("feedback: $difficulty");
    switch (difficulty) {
      case CardDifficulty.easy:
        // TODO: Handle this case.
        break;
      case CardDifficulty.medium:
        // TODO: Handle this case.
        break;
      case CardDifficulty.hard:
        // TODO: Handle this case.
        break;
    }

    notifyListeners();
  }

}