import 'package:flash_dictionary/service/storage_service.dart';
import 'package:flutter/material.dart';

class ResultBloc extends ChangeNotifier { // TODO remove or will I need this?
  ResultBloc() :
    _showDefinitions = StorageService.getLastShowDefinitionsState(),
    _showTranslations = StorageService.getLastShowTranslationsState();

  bool _showDefinitions;
  bool get showDefinitions => _showDefinitions;
  void toggleShowDefinitions() {
    _showDefinitions = !_showDefinitions;
    StorageService.saveLastShowDefinitionsState(showDefinitions);
    notifyListeners();
  }

  bool _showTranslations;
  bool get showTranslations => _showTranslations;
  void toggleShowTranslations() {
    _showTranslations = !_showTranslations;
    StorageService.saveLastShowTranslationsState(showTranslations);
    notifyListeners();
  }
}
