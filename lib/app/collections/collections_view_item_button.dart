import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_page.dart';
import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flutter/material.dart';

class CollectionsViewItemButton extends StatelessWidget {
  const CollectionsViewItemButton({Key? key, required this.collectionDetails}) : super(key: key);

  final CollectionDetails collectionDetails;

  void _onCollectionPressed(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => CollectionEditingPage(collectionDetails: collectionDetails)));
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _onCollectionPressed(context),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(24),
        side: BorderSide(width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
      ),
      child: Row(
        // TODO word wrap
        children: <Widget>[
          Text(
            collectionDetails.name,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 4),
          Text(
            "[${collectionDetails.fromLanguage.value}${collectionDetails.toLanguage != null ? "-${collectionDetails.toLanguage!.value}" : ""}]",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ],
      ),
    );
  }
}