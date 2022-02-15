import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';

class LanguageDropdownButton extends StatelessWidget {
  const LanguageDropdownButton({Key? key, required this.onChanged, required this.value}) : super(key: key);

  final Function(LanguageName?) onChanged;
  final LanguageName value;


  @override
  Widget build(BuildContext context) {
    return DropdownButton<LanguageName>(
      icon: Container(),
      style: appBarButtonTextStyle,
      value: value,
      items: LanguageName.values
          .map<DropdownMenuItem<LanguageName>>((LanguageName languageName) {
        return DropdownMenuItem<LanguageName>(
          value: languageName,
          child: Text(languageName.humanReadable),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue == null) {
          return;
        }
        onChanged(newValue);
      },
    );
  }
}
