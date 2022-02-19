import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';

class CollectionsBloc extends ChangeNotifier {
  void createNewCollection(CollectionDetails collectionDetails) {
    HiveHelper.saveCollectionDetails(collectionDetails);
    notifyListeners();
  }

  List<CollectionDetails> getCollectionList() {
    return HiveHelper.getCollectionList();
  }
}
