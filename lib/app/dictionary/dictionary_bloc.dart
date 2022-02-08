import 'package:flutter/material.dart';

class DictionaryBloc extends ChangeNotifier{

  String _wordToTranslate = "";
  String get wordToTranslate => _wordToTranslate;
  set wordToTranslate(String value) {
    _wordToTranslate = value;
    notifyListeners();
  }

  String languageFrom = "";
  String languageTo = "";

}