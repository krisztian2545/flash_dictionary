import 'package:flutter/material.dart';

class ResultBloc extends ChangeNotifier {

  ResultBloc({this.showDefinitions = true, this.showTranslations = true});

  bool showDefinitions;
  bool showTranslations;

}