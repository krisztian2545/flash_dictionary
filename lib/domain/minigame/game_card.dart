import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/domain/minigame/card_values.dart';

class GameCard {
  GameCard(this.card, this.values);

  final LanguageCard card;
  final CardValues values;

  @override
  String toString() => "GameCard(card(${card.front}), values(${values.confidenceValue}, ${values.lastGameValue}))";

  @override
  bool operator ==(Object other) =>
      other is GameCard &&
      other.runtimeType == runtimeType &&
      other.card.front == card.front;

  @override
  int get hashCode => card.front.hashCode;

}
