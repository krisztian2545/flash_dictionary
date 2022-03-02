import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_bloc.dart';
import 'package:flash_dictionary/app/widgets/delete_confirmation_dialog.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionEditingAppbar extends StatelessWidget {
  const CollectionEditingAppbar({Key? key, required this.height})
      : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: SafeArea(
        child: Row(
          children: <Widget>[
            SizedBox(width: 8),
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_sharp)),
            SizedBox(width: 16),
            Text(
              Provider.of<CollectionEditingBloc>(context, listen: false)
                  .collectionDetails
                  .name,
              style: appBarTextStyle,
            ),
            Spacer(),
            IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const DeleteConfirmationDialog(),
                ).then((agreed) {
                  if (agreed) {
                    HiveHelper.deleteCollection(
                        Provider.of<CollectionEditingBloc>(context, listen: false)
                            .collectionDetails);
                    Navigator.pop(context);
                  }
                }),
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
