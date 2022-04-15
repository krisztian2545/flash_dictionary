import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';

class ResultBloc extends ChangeNotifier {
  ResultBloc({showDefs = true, showTransl = true})
      : _showDefinitions = showDefs,
        _showTranslations = showTransl;

  bool _showDefinitions;
  bool get showDefinitions => _showDefinitions;
  void toggleShowDefinitions() {
    _showDefinitions = !_showDefinitions;
    HiveHelper.saveLastShowDefinitionsState(showDefinitions);
    notifyListeners();
  }

  bool _showTranslations;
  bool get showTranslations => _showTranslations;
  void toggleShowTranslations() {
    _showTranslations = !_showTranslations;
    HiveHelper.saveLastShowTranslationsState(showTranslations);
    notifyListeners();
  }
}
