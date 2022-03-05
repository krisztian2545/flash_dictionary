import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flutter/material.dart';

class MinigameBloc extends ChangeNotifier {
  MinigameBloc({required this.collectionDetails});

  final CollectionDetails collectionDetails;

}