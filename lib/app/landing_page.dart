import 'package:flash_dictionary/app/collections/collections_page.dart';
import 'package:flash_dictionary/app/dictionary/dictionary_page.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: TabBarView(
          children: <Widget>[
            DictionaryPage(),
            CollectionsPage(),
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.black,
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
    );
  }
}
