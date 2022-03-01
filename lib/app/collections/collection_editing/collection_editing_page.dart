import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_appbar.dart';
import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_bloc.dart';
import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_view.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionEditingPage extends StatelessWidget {
  const CollectionEditingPage({Key? key, required this.collectionDetails})
      : super(key: key);

  final CollectionDetails collectionDetails;

  static const int _appBarBaseHeight = 60;

  @override
  Widget build(BuildContext context) {
    var appBarHeight =
        _appBarBaseHeight + MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      backgroundColor: primaryColor,
      body: ChangeNotifierProvider<CollectionEditingBloc>(
        create: (_) =>
            CollectionEditingBloc(collectionDetails: collectionDetails),
        child: Stack(
          children: <Widget>[
            CollectionEditingAppbar(height: appBarHeight),
            Positioned( // TODO make positioned and material together a custom widget
              top: appBarHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: Material(
                color: whitishColor,
                clipBehavior: Clip.antiAlias,
                elevation: 16,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(46)),
                ),
                child: CollectionEditingView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
