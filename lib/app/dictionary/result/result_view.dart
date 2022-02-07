import 'package:flash_dictionary/colors.dart';
import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  const ResultView({Key? key, required this.appBarHeight}) : super(key: key);

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
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("Definition"),
            ),
            SliverList(delegate: SliverChildListDelegate(<Widget>[
              Container(child: Text("Ugat"),),
            ])),
            SliverAppBar(
              title: Text("Translation"),
            ),
            SliverList(delegate: SliverChildListDelegate(<Widget>[
              Container(child: Text("Kutya"),),
            ])),
          ],
        ),
      ),
    );
  }
}
