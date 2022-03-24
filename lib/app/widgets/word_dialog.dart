import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';

class WordDialog extends StatefulWidget {
  const WordDialog(
      {Key? key,
      required this.title,
      required this.initialFront,
      required this.definitions,
      required this.translations})
      : super(key: key);

  final String title;
  final String initialFront;
  final List<DefinitionItem>? definitions;
  final List<TranslationItem>? translations;

  @override
  State<WordDialog> createState() => _WordDialogState();
}

class _WordDialogState extends State<WordDialog> {
  ValueNotifier<CollectionDetails>? selectedCollection;
  late final List<CollectionDetails> collectionList;

  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _definitionsAsString() =>
      widget.definitions
          ?.map((e) => "${e.defintion}\n${e.partOfSpeech}\n${e.examples}")
          .join("\n\n") ??
      "";

  String _translationsAsString() =>
      widget.translations?.map((e) => e.word).join(", ") ?? "";

  @override
  void initState() {
    collectionList = HiveHelper.getCollectionList()
        .where((collection) => (collection.type == CollectionType.translation)
            ? collection.fromLanguage == HiveHelper.getLastUsedFromLanguage() &&
                collection.toLanguage == HiveHelper.getLastUsedToLanguage()
            : collection.fromLanguage == HiveHelper.getLastUsedFromLanguage())
        .toList();

    var lastUsedCollection =
        HiveHelper.getLastUsedCollection(); // TODO set only if languages match
    if (lastUsedCollection != null && collectionList.isNotEmpty) {
      selectedCollection = (collectionList.contains(lastUsedCollection))
          ? ValueNotifier(lastUsedCollection)
          : ValueNotifier(collectionList.first);
    }

    selectedCollection?.addListener(() {
      if (selectedCollection == null) {
        return;
      }

      _backController.text =
          selectedCollection!.value.type == CollectionType.definition
              ? _definitionsAsString()
              : _translationsAsString();
      HiveHelper.saveAsLastUsedCollection(selectedCollection!.value);
    });

    _frontController.text = widget.initialFront;
    _backController.text =
        selectedCollection?.value.type == CollectionType.definition
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
      selectedCollection != null &&
      (_formKey.currentState?.validate() ?? false);

  void _onSubmit() {
    if (validate()) {
      Navigator.pop<Map<String, dynamic>>(context, <String, dynamic>{
        'collectionDetails': selectedCollection!.value,
        'languageCard': LanguageCard(
            front: _frontController.text, back: _backController.text),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(widget.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          TextButton(
            // TODO change color of animation when you hold
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(width: 16),
          TextButton(
            // TODO change color of animation when you hold
            onPressed: selectedCollection == null ? null : _onSubmit,
            child: Text(
              "Save",
              style: TextStyle(
                  color:
                      selectedCollection == null ? Colors.grey : Colors.black,
                  fontSize: 20),
            ),
          ),
        ],
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text("Choose collection:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              CollectionDropDownButton(
                selectedCollectionNotifier: selectedCollection,
                collectionList: collectionList,
              ),
              SizedBox(height: 16),
              Text("Front:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
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
              SizedBox(height: 16),
              Text("Back:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
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

  final ValueNotifier<CollectionDetails>? selectedCollectionNotifier;
  final List<CollectionDetails> collectionList;

  @override
  Widget build(BuildContext context) {
    if (selectedCollectionNotifier == null) {
      return DropdownButton<String>(
        icon: Container(),
        underline: Container(),
        value: "There are no collections",
        items: const [
          DropdownMenuItem<String>(
              value: "There are no collections",
              child: Text("There are no collections",
                  style: TextStyle(color: Colors.grey))),
        ],
        onChanged: (_) {},
      );
    }

    // var collectionList = HiveHelper.getCollectionList();
    print("last used: ${selectedCollectionNotifier!.value.getStringId()}");
    print("list: ${collectionList.map((e) => e.getStringId()).join(", ")}");
    return ValueListenableBuilder<CollectionDetails>(
      valueListenable: selectedCollectionNotifier!,
      builder: (context, value, child) => DropdownButton<CollectionDetails>(
        icon: Container(),
        underline: Container(),
        value: value,
        items: collectionList
            .map((e) => DropdownMenuItem<CollectionDetails>(
                  value: e,
                  child: LimitedBox(
                    maxWidth: 240,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: e.name, style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text:
                                " [${e.fromLanguage.name}${e.toLanguage != null ? "-${e.toLanguage!.name}" : ""}]",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            selectedCollectionNotifier!.value = newValue;
          }
        },
      ),
    );
  }
}
