import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_bloc.dart';
import 'package:flash_dictionary/app/widgets/delete_confirmation_dialog.dart';
import 'package:flash_dictionary/app/widgets/edit_word_dialog.dart';
import 'package:flash_dictionary/domain/minigame/language_card.dart';
import 'package:flutter/material.dart';

enum MoreButtonOption { edit, delete }

class CollectionEditingViewItem extends StatelessWidget {
  const CollectionEditingViewItem({Key? key, required this.languageCard, required this.collectionEditingBloc})
      : super(key: key);

  final LanguageCard languageCard;
  final CollectionEditingBloc collectionEditingBloc;

  void _onEdit(BuildContext context, LanguageCard newValue) {
    collectionEditingBloc.editLanguageCard(languageCard, newValue);
  }

  void _onDelete(BuildContext context) {
    collectionEditingBloc.deleteLanguageCard(languageCard);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(languageCard.front, style: const TextStyle(fontSize: 22)),
        Spacer(),
        PopupMenuButton<MoreButtonOption>(
          child: const Center(
              child: Icon(
            Icons.more_vert_sharp,
            size: 28,
          )),
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
          onSelected: (selected) {
            switch (selected) {
              case MoreButtonOption.edit:
                showDialog(
                  context: context,
                  builder: (_) => EditWordDialog(
                      title: "Edit word",
                      initialFront: languageCard.front,
                      initialBack: languageCard.back),
                ).then((value) {
                  if (value != null) {
                    _onEdit(context, value);
                  }
                });
                break;
              case MoreButtonOption.delete:
                showDialog(context: context, builder: (_) => DeleteConfirmationDialog()).then((agreed) {
                  if (agreed) {
                    _onDelete(context);
                  }
                });
                break;
            }
          },
        ),
        SizedBox(width: 16),
      ],
    );
  }
}
