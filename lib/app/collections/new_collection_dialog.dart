import 'package:flash_dictionary/app/widgets/language_dropdown_button.dart';
import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/storage_service.dart';
import 'package:flutter/material.dart';

class NewCollectionDialog extends StatefulWidget {
  const NewCollectionDialog({Key? key}) : super(key: key);

  @override
  State<NewCollectionDialog> createState() => _NewCollectionDialogState();
}

class _NewCollectionDialogState extends State<NewCollectionDialog> {
  final ValueNotifier<CollectionType> _collectionType =
      ValueNotifier(CollectionType.translation);

  final ValueNotifier<LanguageName> _fromLanguage =
      ValueNotifier(StorageService.getLastUsedFromLanguage());

  final ValueNotifier<LanguageName> _toLanguage =
      ValueNotifier(StorageService.getLastUsedToLanguage());

  final TextEditingController _collectionNameController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateCollectionNameField(String? value) {
    if (value == null || value == "") {
      return "Name can't be empty!";
    }

    var collectionList = StorageService.getCollectionList();
    for (int i = 0; i < collectionList.length; i++) {
      var collection = collectionList[i];
      if (collection.name.toLowerCase() == value.toLowerCase() &&
          collection.type == _collectionType.value &&
          collection.fromLanguage == _fromLanguage.value) {
        if (collection.type == CollectionType.translation &&
            collection.toLanguage != _toLanguage.value) {
          continue;
        }
        return "Name already exsists with this settings!";
      }
    }
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop<CollectionDetails>(
          context,
          CollectionDetails(
            name: _collectionNameController.text,
            type: _collectionType.value,
            fromLanguage: _fromLanguage.value,
            toLanguage: _collectionType.value == CollectionType.translation
                ? _toLanguage.value
                : null,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text("Create new collection",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          TextButton(
            onPressed: _onSubmit,
            child: const Text(
              "Create",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(width: 4),
        ],
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 8),
              TextFormField(
                // TODO make text bigger?
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => _validateCollectionNameField(value),
                textCapitalization: TextCapitalization.sentences,
                controller: _collectionNameController,
                decoration: const InputDecoration(
                    errorMaxLines: 2,
                    border: OutlineInputBorder(),
                    labelText: "Collection name"),
              ),
              const SizedBox(height: 32),
              const Text(
                "Collection type:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              NewCollectionDialogSettings(
                  collectionType: _collectionType,
                  fromLanguage: _fromLanguage,
                  toLanguage: _toLanguage,
                  onChange: () => _formKey.currentState!.validate()),
            ],
          ),
        ),
      ),
    );
  }
}

class NewCollectionDialogSettings extends StatelessWidget {
  const NewCollectionDialogSettings(
      {Key? key,
      required this.collectionType,
      required this.fromLanguage,
      required this.toLanguage,
      required this.onChange})
      : super(key: key);

  final VoidCallback onChange;

  final ValueNotifier<CollectionType> collectionType;

  final ValueNotifier<LanguageName> fromLanguage;

  final ValueNotifier<LanguageName> toLanguage;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CollectionType>(
      valueListenable: collectionType,
      builder: (context, value, child) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[

                ////////////////////////// TRANSLATION TYPE BUTTON
                OutlinedButton(
                  onPressed: () {
                    collectionType.value = CollectionType.translation;
                    onChange();
                  },
                  child: const Text("Translation",
                      style: TextStyle(color: Colors.black)),
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: value == CollectionType.translation ? 2 : 0)),
                ),
                const Spacer(),

                ////////////////////////// DEFINITION TYPE BUTTON
                OutlinedButton(
                  onPressed: () {
                    collectionType.value = CollectionType.definition;
                    onChange();
                  },
                  child: const Text("Definition",
                      style: TextStyle(color: Colors.black)),
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: value == CollectionType.definition ? 2 : 0)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[

                ////////////////////////// FROM LANGUAGE
                Column(
                  children: <Widget>[
                    const Text("From",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    ValueListenableBuilder<LanguageName>(
                      valueListenable: fromLanguage,
                      builder: (context, value, child) =>
                          LanguageDropdownButton(
                              value: value,
                              onChanged: (value) {
                                if (toLanguage.value == value) {
                                  toLanguage.value = fromLanguage.value;
                                }
                                fromLanguage.value = value!;
                                onChange();
                              }),
                    ),
                  ],
                ),
                const Spacer(),

                ////////////////////////// TO LANGUAGE
                if (value == CollectionType.translation)
                  Column(
                    children: <Widget>[
                      const Text("To",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      ValueListenableBuilder<LanguageName>(
                        valueListenable: toLanguage,
                        builder: (context, value, child) =>
                            LanguageDropdownButton(
                                value: value,
                                onChanged: (value) {
                                  if (fromLanguage.value == value) {
                                    fromLanguage.value = toLanguage.value;
                                  }
                                  toLanguage.value = value!;
                                  onChange();
                                }),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
