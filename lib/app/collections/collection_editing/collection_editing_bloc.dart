import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/service/storage_service.dart';
import 'package:flutter/material.dart';

class CollectionEditingBloc extends ChangeNotifier {
  CollectionEditingBloc({required this.collectionDetails});

  final CollectionDetails collectionDetails;

  Future<List<LanguageCard>> getLanguageCards() =>
      StorageService.getLanguageCardsFromCollection(collectionDetails);

  void editLanguageCard(LanguageCard oldValue, LanguageCard newValue) {
    StorageService.updateLanguageCardInCollection(
        collectionDetails, oldValue, newValue);
    notifyListeners();
  }

  void deleteLanguageCard(LanguageCard languageCard) {
    StorageService.deleteLanguageCardFromCollection(
        collectionDetails, languageCard);
    notifyListeners();
  }
}
