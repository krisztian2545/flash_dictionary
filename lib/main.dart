import 'package:flash_dictionary/app/landing_page.dart';
import 'package:flash_dictionary/service/storage_service.dart';
import 'package:flash_dictionary/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  await StorageService.initAndOpenBoxes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flash Dictionary',
      theme: themeData,
      home: const LandingPage(),
    );
  }
}