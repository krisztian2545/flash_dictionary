import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_bloc.dart';
import 'package:flash_dictionary/app/minigame/minigame_page.dart';
import 'package:flash_dictionary/app/widgets/delete_confirmation_dialog.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class CollectionEditingAppbar extends StatelessWidget {
  const CollectionEditingAppbar({Key? key}) : super(key: key);

  void _onBackButtonPressed(BuildContext context) {
    Navigator.pop(context);
    Hive.box(Provider.of<CollectionEditingBloc>(context, listen: false)
            .collectionDetails
            .getStringId())
        .close();
  }

  void _onPlayButtonPressed(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MinigamePage(
                collectionDetails:
                    Provider.of<CollectionEditingBloc>(context, listen: false)
                        .collectionDetails)));
  }

  void _onDeleteButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const DeleteConfirmationDialog(),
    ).then((agreed) {
      if (agreed) {
        HiveHelper.deleteCollection(
            Provider.of<CollectionEditingBloc>(context, listen: false)
                .collectionDetails);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // TODO create a unified appbar
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          IconButton(
              onPressed: () => _onBackButtonPressed(context),
              icon: const Icon(Icons.arrow_back_sharp)),
          const SizedBox(width: 16),
          LimitedBox(
            maxWidth: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                Provider.of<CollectionEditingBloc>(context, listen: false)
                    .collectionDetails
                    .name,
                style: appBarTextStyle.copyWith(fontSize: 24),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => _onPlayButtonPressed(context),
            icon: Icon(Icons.play_arrow_outlined, size: 32),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () => _onDeleteButtonPressed(context),
            icon: const Icon(Icons.delete),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
