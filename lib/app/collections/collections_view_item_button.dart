import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_page.dart';
import 'package:flash_dictionary/app/collections/collections_bloc.dart';
import 'package:flash_dictionary/app/widgets/play_minigame_button.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionsViewItemButton extends StatelessWidget {
  const CollectionsViewItemButton({Key? key, required this.collectionDetails})
      : super(key: key);

  final CollectionDetails collectionDetails;

  void _onCollectionPressed(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CollectionEditingPage(
                collectionDetails: collectionDetails))).then((value) =>
        Provider.of<CollectionsBloc>(context, listen: false).rebuild());
  }

  @override
  Widget build(BuildContext context) {
    double buttonContentWidth = MediaQuery.of(context).size.width - 104; // screen size - paddings
    // print("button width: ${buttonContentWidth * 0.75}");

    return OutlinedButton(
      onPressed: () => _onCollectionPressed(context),
      style: OutlinedButton.styleFrom(
        elevation: 1,
        backgroundColor: whitishColor,
        padding: const EdgeInsets.all(20),
        side: const BorderSide(width: borderWidth),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      child: Row(
        // TODO word wrap
        children: <Widget>[
          LimitedBox(
            maxWidth: buttonContentWidth * 0.8,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: collectionDetails.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        " [${collectionDetails.fromLanguage.name}${collectionDetails.toLanguage != null ? "-${collectionDetails.toLanguage!.name}" : ""}]",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          PlayMinigameButton(collectionDetails: collectionDetails),
        ],
      ),
    );
  }
}
