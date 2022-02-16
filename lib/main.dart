import 'package:flash_dictionary/app/landing_page.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  await HiveHelper.initAndOpenBoxes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flash Dictionary',
      theme: ThemeData( // TODO learn about styling and refactor accordingly
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(),
    );
  }
}