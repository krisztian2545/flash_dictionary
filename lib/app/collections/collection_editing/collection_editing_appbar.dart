import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_bloc.dart';
import 'package:flash_dictionary/app/widgets/delete_confirmation_dialog.dart';
import 'package:flash_dictionary/app/widgets/play_minigame_button.dart';
import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/service/storage_service.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class CollectionEditingAppbar extends StatelessWidget {
  const CollectionEditingAppbar({Key? key}) : super(key: key);

  void _onBackButtonPressed(
      BuildContext context, CollectionDetails collection) {
    Navigator.pop(context);
    Hive.box(collection.getStringId()).close();
  }

  void _onDeleteButtonPressed(
      BuildContext context, CollectionDetails collection) {
    showDialog(
      context: context,
      builder: (_) => const DeleteConfirmationDialog(),
    ).then((agreed) {
      if (agreed) {
        StorageService.deleteCollection(collection);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionDetails collectionDetails =
        Provider.of<CollectionEditingBloc>(context, listen: false)
            .collectionDetails;

    return SafeArea(
      // TODO create a unified appbar
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          IconButton(
              onPressed: () => _onBackButtonPressed(context, collectionDetails),
              icon: const Icon(Icons.arrow_back_sharp)),
          const SizedBox(width: 16),
          LimitedBox(
            maxWidth: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                collectionDetails.name,
                style: appBarTextStyle.copyWith(fontSize: 24),
              ),
            ),
          ),
          const Spacer(),
          PlayMinigameButton(collectionDetails: collectionDetails),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _onDeleteButtonPressed(context, collectionDetails),
            icon: const Icon(Icons.delete),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
