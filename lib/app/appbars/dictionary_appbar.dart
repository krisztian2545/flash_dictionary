import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class DictionaryAppBar extends StatelessWidget {
  const DictionaryAppBar({Key? key, required this.height}) : super(key: key);

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
          child: Column(
            children: <Widget>[
              Container(
                // color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    TextButton(
                        onPressed: () {},
                        child: Text("English", style: appBarTextStyle)),
                    Spacer(),
                    Text("<>", style: appBarTextStyle),
                    Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text("Hungarian", style: appBarTextStyle)),
                  ],
                ),
              ),
              Container(
                // color: Colors.green,
                padding: EdgeInsets.only(left: 8, right: 42),
                child: Row(
                  children: <Widget>[
                    Expanded(child: SearchField(suggestions: ['Coming soon'])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
