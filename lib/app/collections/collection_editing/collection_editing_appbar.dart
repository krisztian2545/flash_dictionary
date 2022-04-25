import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_bloc.dart';
import 'package:flash_dictionary/app/widgets/delete_confirmation_dialog.dart';
import 'package:flash_dictionary/app/widgets/play_minigame_button.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionEditingAppbar extends StatelessWidget {
  const CollectionEditingAppbar({Key? key}) : super(key: key);

  void _onBackButtonPressed(BuildContext context, CollectionEditingBloc bloc) {
    Navigator.pop(context);
    bloc.close(); // maybe i could do this in a WillPopScope
  }

  void _onDeleteButtonPressed(
      BuildContext context, CollectionEditingBloc bloc) {
    showDialog(
      context: context,
      builder: (_) => const DeleteConfirmationDialog(),
    ).then((agreed) {
      if (agreed) {
        bloc.deleteCollection();
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionEditingBloc bloc = Provider.of<CollectionEditingBloc>(context, listen: false);

    return SafeArea(
      // TODO create a unified appbar
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          IconButton(
              onPressed: () => _onBackButtonPressed(context, bloc),
              icon: const Icon(Icons.arrow_back_sharp)),
          const SizedBox(width: 16),
          LimitedBox(
            maxWidth: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                bloc.collectionDetails.name,
                style: appBarTextStyle.copyWith(fontSize: 24),
              ),
            ),
          ),
          const Spacer(),
          PlayMinigameButton(collectionDetails: bloc.collectionDetails),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _onDeleteButtonPressed(context, bloc),
            icon: const Icon(Icons.delete),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
