import 'package:flash_dictionary/colors.dart';
import 'package:flutter/material.dart';

class PositionedMaterial extends StatelessWidget {
  const PositionedMaterial({Key? key, required this.appBarHeight, required this.child}) : super(key: key);

  final Widget child;
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
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(46)),
        ),
        child: child,
      ),
    );
  }
}
