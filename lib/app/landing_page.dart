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
        backgroundColor: primaryColor,
        body: const TabBarView(
          children: <Widget>[
            DictionaryPage(),
            CollectionsPage(), // TODO dismiss keyboard when switching tab
          ],
        ),
        bottomNavigationBar: Material(
          color: primaryColor,
          elevation: 16,
          child: TabBar(
            labelColor: Colors.black,
            indicatorPadding: const EdgeInsets.only(bottom: 6, left: 64, right: 64),
            indicatorColor: Colors.black,
            overlayColor: MaterialStateProperty.all(pastelGreen),
            // overlayColor: MaterialStateProperty.all(Colors.black),
            tabs: const <Widget>[
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
