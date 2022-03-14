import 'package:flash_dictionary/app/collections/collections_bloc.dart';
import 'package:flash_dictionary/app/collections/new_collection_dialog.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionsAppBar extends StatelessWidget {
  const CollectionsAppBar({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Row(
            children: <Widget>[
              SizedBox(width: 26),
              Text("Collections", style: appBarTextStyle),
              Spacer(flex: 5),
              OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => NewCollectionDialog(),
                  ).then((result) {
                    if (result == null) {
                      return;
                    }
                    Provider.of<CollectionsBloc>(context, listen: false)
                        .createNewCollection(result);
                  });
                },
                style: OutlinedButton.styleFrom(side: BorderSide(width: borderWidth)),
                child: Text("New", style: appBarButtonTextStyle),
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
