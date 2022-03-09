import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/domain/minigame/game_card.dart';
import 'package:flutter/material.dart';

class MinigameBloc extends ChangeNotifier {
  MinigameBloc({required this.collectionDetails, required this.gameCards});

  final CollectionDetails collectionDetails;
  final List<GameCard> gameCards;

  late LanguageCard _currentLanguageCard;
  LanguageCard get currentLanguageCard => _currentLanguageCard;

  void pickRandomCard() {

  }

}