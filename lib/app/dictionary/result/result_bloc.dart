import 'package:flutter/material.dart';

class ResultBloc extends ChangeNotifier {
  ResultBloc({showDefs = true, showTransl = true})
      : _showDefinitions = showDefs,
        _showTranslations = showTransl;

  bool _showDefinitions;
  bool get showDefinitions => _showDefinitions;
  void toggleShowDefinitions() {
    _showDefinitions = !_showDefinitions;
    notifyListeners();
  }

  bool _showTranslations;
  bool get showTranslations => _showTranslations;
  void toggleShowTranslations() {
    _showTranslations = !_showTranslations;
    notifyListeners();
  }
}
