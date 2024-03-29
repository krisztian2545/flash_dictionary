import 'package:flash_dictionary/app/collections/collections_view_item_button.dart';
import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flutter/material.dart';

class CollectionsView extends StatelessWidget {
  const CollectionsView({Key? key, required this.collectionList})
      : super(key: key);

  final List<CollectionDetails> collectionList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(32),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: collectionList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 32),
      itemBuilder: (context, index) => CollectionsViewItemButton(collectionDetails: collectionList[index]),
    );
  }
}
