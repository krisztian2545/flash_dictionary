import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_appbar.dart';
import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_bloc.dart';
import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_view.dart';
import 'package:flash_dictionary/app/widgets/positioned_material.dart';
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: appBarHeight,
              child: Consumer<CollectionEditingBloc>(
                builder: (context, bloc, child) => CollectionEditingAppbar(),
              ),
            ),
            PositionedMaterial(
              appBarHeight: appBarHeight,
              child: Consumer<CollectionEditingBloc>(
                builder: (context, bloc, child) => CollectionEditingView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
