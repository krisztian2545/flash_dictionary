import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_page.dart';
import 'package:flash_dictionary/app/collections/collections_bloc.dart';
import 'package:flash_dictionary/app/minigame/minigame_page.dart';
import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionsViewItemButton extends StatelessWidget {
  const CollectionsViewItemButton({Key? key, required this.collectionDetails})
      : super(key: key);

  final CollectionDetails collectionDetails;

  void _onCollectionPressed(BuildContext context) {
    // TODO close box after colelction closed
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CollectionEditingPage(
                collectionDetails: collectionDetails))).then((value) =>
        Provider.of<CollectionsBloc>(context, listen: false).rebuild());
  }

  void _onPlayButtonPressed(BuildContext context) {
    // TODO close box after game ended
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                MinigamePage(collectionDetails: collectionDetails)));
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => _onCollectionPressed(context),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        side: const BorderSide(width: 2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      child: Row(
        // TODO word wrap
        children: <Widget>[
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     LimitedBox(
          //       maxWidth: 240,
          //       child: Text(
          //         collectionDetails.name,
          //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //         maxLines: 2,
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //     ),
          //     SizedBox(width: 4),
          //     Text(
          //       "[${collectionDetails.fromLanguage.value}${collectionDetails.toLanguage != null ? "-${collectionDetails.toLanguage!.value}" : ""}]",
          //       style: TextStyle(
          //           fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          //     ),
          //   ],
          // ),

          LimitedBox(
            maxWidth: 240,
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: collectionDetails.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        " [${collectionDetails.fromLanguage.value}${collectionDetails.toLanguage != null ? "-${collectionDetails.toLanguage!.value}" : ""}]",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () => _onPlayButtonPressed(context),
            icon: Icon(Icons.play_arrow_outlined, size: 48),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
