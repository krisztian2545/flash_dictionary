import 'package:flash_dictionary/app/collections/collections_appbar.dart';
import 'package:flash_dictionary/app/collections/collections_bloc.dart';
import 'package:flash_dictionary/app/collections/collections_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CollectionsBloc>(
      create: (context) => CollectionsBloc(),
      child: Stack(
        children: <Widget>[
          CollectionsAppBar(height: 90),
          Consumer<CollectionsBloc>(
            builder: (context, collectionsBloc, child) {
              return CollectionsView(appBarHeight: 90);
            },
          ),
        ],
      ),
    );
  }
}
