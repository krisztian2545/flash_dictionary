import 'package:flash_dictionary/app/collections/collections_appbar.dart';
import 'package:flash_dictionary/app/collections/collections_bloc.dart';
import 'package:flash_dictionary/app/collections/collections_view.dart';
import 'package:flash_dictionary/app/widgets/positioned_material.dart';
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
    // print(
    //     "appBarHeight: $appBarHeight"); // TODO remove prints from prodduction code
    return ChangeNotifierProvider<CollectionsBloc>(
      create: (context) => CollectionsBloc(),
      child: Stack(
        children: <Widget>[
          CollectionsAppBar(height: appBarHeight),
          PositionedMaterial(
            appBarHeight: appBarHeight,
            child: Consumer<CollectionsBloc>(
              builder: (context, collectionsBloc, child) {
                return CollectionsView(
                    collectionList: collectionsBloc.getCollectionList());
              },
            ),
          ),
        ],
      ),
    );
  }
}
