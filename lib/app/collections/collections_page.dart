import 'package:flash_dictionary/app/appbars/collections_appbar.dart';
import 'package:flash_dictionary/app/collections/collections_view.dart';
import 'package:flutter/material.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CollectionsAppBar(height: 80),
        CollectionsView(appBarHeight: 80),
      ],
    );
  }
}
