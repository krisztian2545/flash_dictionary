import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flutter/material.dart';

class CollectionEditingBloc extends ChangeNotifier {
  CollectionEditingBloc({required this.collectionDetails});

  final CollectionDetails collectionDetails;
}