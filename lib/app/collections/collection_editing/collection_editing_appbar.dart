import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_bloc.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionEditingAppbar extends StatelessWidget {
  const CollectionEditingAppbar({Key? key, required this.height})
      : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: SafeArea(
        child: Row(
          children: <Widget>[
            SizedBox(width: 26),
            Text(
              Provider.of<CollectionEditingBloc>(context, listen: false)
                  .collectionDetails
                  .name,
              style: appBarTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
