import 'package:flash_dictionary/app/collections/collections_page.dart';
import 'package:flash_dictionary/app/dictionary/dictionary_page.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: primaryColor,
        backgroundColor: whitishColor,
        body: TabBarView(
          children: <Widget>[
            DictionaryPage(),
            CollectionsPage(),
          ],
        ),
        bottomNavigationBar: Container(
          // color: primaryColor,
          decoration: BoxDecoration(
            color: primaryColor,
            border: Border(top: BorderSide(width: 1)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
              )
            ],
          ),
          child: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            // overlayColor: MaterialStateProperty.all(primaryColor),
            overlayColor: MaterialStateProperty.all(Colors.black),
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.translate),
              ),
              Tab(
                icon: Icon(Icons.list_alt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
