import 'package:flash_dictionary/domain/minigame/language_card.dart';
import 'package:flutter/material.dart';

class CollectionEditingViewItem extends StatelessWidget {
  const CollectionEditingViewItem({Key? key, required this.languageCard})
      : super(key: key);

  final LanguageCard languageCard;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(languageCard.front),
      ],
    );
  }
}
