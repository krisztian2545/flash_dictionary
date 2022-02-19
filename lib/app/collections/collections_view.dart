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
      itemCount: collectionList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 32),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Row(
          children: <Widget>[
            Text(
              collectionList[index].name,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
