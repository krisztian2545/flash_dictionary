import 'package:flash_dictionary/app/collections/collections_appbar.dart';
import 'package:flash_dictionary/app/collections/collections_bloc.dart';
import 'package:flash_dictionary/app/collections/collections_view.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  static const double _appBarBaseHeight = 60;

  @override
  Widget build(BuildContext context) {
    var appBarHeight =
        _appBarBaseHeight + MediaQuery.of(context).viewPadding.top;
    print(
        "appBarHeight: $appBarHeight"); // TODO remove prints from prodduction code
    return ChangeNotifierProvider<CollectionsBloc>(
      create: (context) => CollectionsBloc(),
      child: Stack(
        children: <Widget>[
          CollectionsAppBar(height: appBarHeight),
          Positioned(
            top: appBarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              // color: whitishColor,
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              // elevation: 16,
              // shape: const BeveledRectangleBorder(
              //   borderRadius: BorderRadius.only(topRight: Radius.circular(46)),
              // ),
              child: Consumer<CollectionsBloc>(
                builder: (context, collectionsBloc, child) {
                  return CollectionsView(collectionList: collectionsBloc.getCollectionList());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
