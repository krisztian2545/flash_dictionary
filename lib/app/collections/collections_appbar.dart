import 'package:flash_dictionary/app/collections/collections_bloc.dart';
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
      child: SafeArea(
        child: Container(
          child: Row(
            children: <Widget>[
              Spacer(),
              Text("Collections", style: appBarTextStyle),
              Spacer(flex: 5),
              OutlinedButton(
                onPressed: () {
                  Provider.of<CollectionsBloc>(context, listen: false).createNewCollection(context);
                },
                style: OutlinedButton.styleFrom(side: BorderSide(width: 2)),
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