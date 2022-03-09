import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/domain/minigame/card_values.dart';

class GameCard {
  GameCard(this.card, this.values);

  final LanguageCard card;
  final CardValues values;
}