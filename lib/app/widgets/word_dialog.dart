import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/service/storage_service.dart';
import 'package:flutter/material.dart';

class WordDialog extends StatefulWidget {
  const WordDialog(
      {Key? key,
      required this.initialFront,
      required this.definitions,
      required this.translations,
      required this.fromLanguage,
      required this.toLanguage})
      : super(key: key);

  final String initialFront;
  final List<DefinitionItem>? definitions;
  final List<TranslationItem>? translations;
  final LanguageName fromLanguage;
  final LanguageName toLanguage;

  @override
  State<WordDialog> createState() => _WordDialogState();
}

class _WordDialogState extends State<WordDialog> {
  ValueNotifier<CollectionDetails?> selectedCollection = ValueNotifier(null);
  late final List<CollectionDetails> collectionList;

  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _definitionsAsString() =>
      widget.definitions?.map((e) {
        String text = "Def.: [${e.partOfSpeech}] ${e.defintion}";
        if (e.examples.isNotEmpty) {
          text += "\nExamples: ${e.examples.join("; ")}";
        }
        return text;
      }).join("\n\n") ??
      "";

  String _translationsAsString() =>
      widget.translations?.map((e) => e.word).join(", ") ?? "";

  @override
  void initState() {
    collectionList = StorageService.getCollectionList()
        .where((collection) => (collection.type == CollectionType.translation)
            ? collection.fromLanguage == widget.fromLanguage &&
                collection.toLanguage == widget.toLanguage
            : collection.fromLanguage == widget.fromLanguage)
        .toList();

    var lastUsedCollection = StorageService.getLastUsedCollection();
    if (collectionList.isNotEmpty) {
      selectedCollection.value = (lastUsedCollection != null &&
              collectionList.contains(lastUsedCollection))
          ? lastUsedCollection
          : collectionList.first;
    }

    selectedCollection.addListener(() {
      if (selectedCollection.value == null) { // TODO maybe I dont even need this anymore
        return;
      }

      _backController.text =
          selectedCollection.value!.type == CollectionType.definition
              ? _definitionsAsString()
              : _translationsAsString();
      StorageService.saveAsLastUsedCollection(selectedCollection.value!);
    });

    _frontController.text = widget.initialFront;
    _backController.text =
        (selectedCollection.value?.type ?? CollectionType.translation) == CollectionType.definition
            ? _definitionsAsString()
            : _translationsAsString();

    super.initState();
  }

  String? _formFieldValidator(String? value) {
    if (value == null || value == "") {
      return "Field can't be empty!";
    }
  }

  bool validate() =>
      selectedCollection.value != null &&
      (_formKey.currentState?.validate() ?? false);

  void _onSubmit() {
    if (validate()) {
      Navigator.pop<Map<String, dynamic>>(context, <String, dynamic>{
        'collectionDetails': selectedCollection.value,
        'languageCard': LanguageCard(
            front: _frontController.text, back: _backController.text),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: AlertDialog(
        title: const Text("Add word to collection",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(width: 16),
          TextButton(
            onPressed: selectedCollection.value == null ? null : _onSubmit,
            child: Text(
              "Save",
              style: TextStyle(
                  color:
                      selectedCollection.value == null ? Colors.grey : Colors.black,
                  fontSize: 20),
            ),
          ),
        ],
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text("Choose collection:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              CollectionDropDownButton(
                selectedCollectionNotifier: selectedCollection,
                collectionList: collectionList,
              ),
              const SizedBox(height: 16),
              const Text("Front:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                // TODO maybe check if front already exists in deck or just overwrite
                controller: _frontController,
                validator: _formFieldValidator,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              const Text("Back:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _backController,
                validator: _formFieldValidator,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CollectionDropDownButton extends StatelessWidget {
  const CollectionDropDownButton(
      {Key? key,
      required this.selectedCollectionNotifier,
      required this.collectionList})
      : super(key: key);

  final ValueNotifier<CollectionDetails?> selectedCollectionNotifier;
  final List<CollectionDetails> collectionList;

  @override
  Widget build(BuildContext context) {
    print("last used: ${selectedCollectionNotifier.value?.getStringId()}");
    print("list: ${collectionList.map((e) => e.getStringId()).join(", ")}");
    return ValueListenableBuilder<CollectionDetails?>(
      valueListenable: selectedCollectionNotifier,
      builder: (context, value, child) => DropdownButton<CollectionDetails>(
        icon: Container(),
        underline: Container(),
        disabledHint: Expanded(
          child: RichText(
            text: TextSpan( text: "There are no collections in these languages.",
                style: TextStyle(color: Colors.grey)),
          ),
        ),
        value: value,
        items: collectionList
            .map((e) => DropdownMenuItem<CollectionDetails>(
                  value: e,
                  child: LimitedBox(
                    maxWidth: 240,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: e.name,
                              style: const TextStyle(color: Colors.black)),
                          TextSpan(
                            text:
                                " [${e.fromLanguage.name}${e.toLanguage != null ? "-${e.toLanguage!.name}" : ""}]",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            selectedCollectionNotifier.value = newValue;
          }
        },
      ),
    );
  }
}
