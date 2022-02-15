import 'package:flash_dictionary/app/collections/new_collection_dialog.dart';
import 'package:flutter/material.dart';

class CollectionsBloc extends ChangeNotifier {
  void createNewCollection(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => NewCollectionDialog(),
    );
  }
}
