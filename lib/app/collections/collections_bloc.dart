import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/service/storage_service.dart';
import 'package:flutter/material.dart';

class CollectionsBloc extends ChangeNotifier {
  void createNewCollection(CollectionDetails collectionDetails) {
    StorageService.saveCollectionDetails(collectionDetails);
    notifyListeners();
  }

  List<CollectionDetails> getCollectionList() {
    return StorageService.getCollectionList();
  }

  void rebuild() => notifyListeners();
}
