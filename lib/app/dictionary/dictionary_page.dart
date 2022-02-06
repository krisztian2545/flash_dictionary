import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  static final double _appBarHeight = 130;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      body: Stack(
        children: [

          Positioned(
            top: _appBarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              clipBehavior: Clip.antiAlias,
              elevation: 16,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(46)),
              ),
              child: ListView(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                children: [
                  Text("aiuysgfjkgy"),
                  Divider(
                    thickness: 6,
                  ),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                  Text("aiuysgfjkgy"),
                  Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
