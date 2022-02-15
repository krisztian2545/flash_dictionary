import 'package:flash_dictionary/colors.dart';
import 'package:flutter/material.dart';

class CollectionsView extends StatelessWidget {
  const CollectionsView({Key? key, required this.appBarHeight}) : super(key: key);

  final double appBarHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: appBarHeight,
      left: 0,
      right: 0,
      bottom: 0,
      child: Material(
        color: whitishColor,
        clipBehavior: Clip.antiAlias,
        elevation: 16,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(46)),
        ),
        child: ListView(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          children: [

          ],
        ),
      ),
    );
  }
}
