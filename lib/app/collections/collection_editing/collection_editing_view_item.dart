import 'package:flash_dictionary/domain/minigame/language_card.dart';
import 'package:flutter/material.dart';

enum MoreButtonOption { edit, delete }

class CollectionEditingViewItem extends StatelessWidget {
  const CollectionEditingViewItem({Key? key, required this.languageCard})
      : super(key: key);

  final LanguageCard languageCard;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(languageCard.front, style: const TextStyle(fontSize: 22)),
        Spacer(),
        PopupMenuButton<MoreButtonOption>(
          child: const Center(child: Icon(Icons.more_vert_sharp, size: 28,)),
          itemBuilder: (context) => const <PopupMenuEntry<MoreButtonOption>>[
            PopupMenuItem<MoreButtonOption>(
              value: MoreButtonOption.edit,
              child: Text("Edit"),
            ),
            PopupMenuItem<MoreButtonOption>(
              value: MoreButtonOption.delete,
              child: Text("Delete"),
            ),
          ],
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
