import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';

class CollectionEditingBloc extends ChangeNotifier {
  CollectionEditingBloc({required this.collectionDetails});

  final CollectionDetails collectionDetails;

  void editLanguageCard(LanguageCard oldValue, LanguageCard newValue) {
    HiveHelper.updateLanguageCardInCollection(collectionDetails, oldValue, newValue);
    notifyListeners();
  }

  void deleteLanguageCard(LanguageCard languageCard) {
    HiveHelper.deleteLanguageCardFromCollection(collectionDetails, languageCard);
    notifyListeners();
  }
}