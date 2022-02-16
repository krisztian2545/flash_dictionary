import 'package:flash_dictionary/app/widgets/language_dropdown_button.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';

class NewCollectionDialog extends StatefulWidget {
  const NewCollectionDialog({Key? key}) : super(key: key);

  @override
  State<NewCollectionDialog> createState() => _NewCollectionDialogState();
}

class _NewCollectionDialogState extends State<NewCollectionDialog> {
  final ValueNotifier<bool> _isTranslationTypeSelected = ValueNotifier(true);
  final ValueNotifier<LanguageName> _fromLanguage =
      ValueNotifier(HiveHelper.getLastUsedFromLanguage());
  final ValueNotifier<LanguageName> _toLanguage =
      ValueNotifier(HiveHelper.getLastUsedToLanguage());

  void toggleCollectionType() {
    _isTranslationTypeSelected.value = !_isTranslationTypeSelected.value;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Create new collection"),
      actions: [
        TextButton(
          // TODO change color of animation when you hold
          onPressed: () => Navigator.pop(context, "ok"),
          child: const Text(
            "Create",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        SizedBox(width: 4),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Collection name"),
            ),
            SizedBox(height: 16),
            Text(
              "Collection type:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ValueListenableBuilder<bool>(
              valueListenable: _isTranslationTypeSelected,
              builder: (context, value, child) {
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        OutlinedButton(
                          onPressed: toggleCollectionType,
                          child: Text(
                            "Translation",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: value ? 2 : 0),
                          ),
                        ),
                        Spacer(),
                        OutlinedButton(
                          onPressed: toggleCollectionType,
                          child: Text(
                            "Definition",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: value ? 0 : 2),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("From"),
                            ValueListenableBuilder<LanguageName>(
                              valueListenable: _fromLanguage,
                              builder: (context, value, child) {
                                return LanguageDropdownButton(
                                    onChanged: (value) =>
                                        _fromLanguage.value = value!,
                                    value: value);
                              },
                            ),
                          ],
                        ),
                        if (!_isTranslationTypeSelected.value)
                          Column(
                            children: <Widget>[
                              Text("To"),
                              ValueListenableBuilder<LanguageName>(
                                valueListenable: _toLanguage,
                                builder: (context, value, child) {
                                  return LanguageDropdownButton(
                                    onChanged: (value) => _toLanguage.value = value!,
                                    value: value,
                                  );
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
