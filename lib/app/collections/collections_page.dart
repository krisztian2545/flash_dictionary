import 'package:flash_dictionary/app/collections/collections_appbar.dart';
import 'package:flash_dictionary/app/collections/collections_bloc.dart';
import 'package:flash_dictionary/app/collections/collections_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  final double _appBarBaseHeight = 90;

  @override
  Widget build(BuildContext context) {
    var appBarHeight = _appBarBaseHeight + MediaQuery.of(context).viewPadding.top;
    print("appBarHeight: $appBarHeight"); // TODO remove prints from prodduction code
    return ChangeNotifierProvider<CollectionsBloc>(
      create: (context) => CollectionsBloc(),
      child: Stack(
        children: <Widget>[
          CollectionsAppBar(height: appBarHeight),
          Consumer<CollectionsBloc>(
            builder: (context, collectionsBloc, child) {
              return CollectionsView(appBarHeight: appBarHeight);
            },
          ),
        ],
      ),
    );
  }
}
