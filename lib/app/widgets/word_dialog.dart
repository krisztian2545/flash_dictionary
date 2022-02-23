import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';

class WordDialog extends StatefulWidget {
  const WordDialog({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WordDialog> createState() => _WordDialogState();
}

class _WordDialogState extends State<WordDialog> {
  ValueNotifier<CollectionDetails>? selectedCollection;
  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController = TextEditingController();

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var lastUsedCollection = HiveHelper.getLastUsedCollection();
    if (lastUsedCollection != null) {
      selectedCollection = ValueNotifier(lastUsedCollection);
    }

    super.initState();
  }

  bool validate() =>
      selectedCollection != null &&
      _frontController.text.isNotEmpty &&
      _backController.text.isNotEmpty;

  

  void _onSubmit() {
    if (validate()) {
      Navigator.pop(context);
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
          Spacer(),
          TextButton(
            // TODO change color of animation when you hold
            onPressed: _onSubmit,
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CollectionDropDownButton(
                  selectedCollectionNotifier: selectedCollection),
              SizedBox(height: 16),
              Text("Front:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                controller: _frontController,
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
      {Key? key, required this.selectedCollectionNotifier})
      : super(key: key);

  final ValueNotifier<CollectionDetails>? selectedCollectionNotifier;

  @override
  Widget build(BuildContext context) {
    if (selectedCollectionNotifier == null) {
      return DropdownButton<String>(
        icon: Container(),
        underline: Container(),
        value: "There are no collections",
        items: [
          DropdownMenuItem<String>(
              value: "There are no collections",
              child: Text("There are no collections")),
        ],
        onChanged: (_) {},
      );
    }

    var collectionList = HiveHelper.getCollectionList();
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
                  child: Row(
                    children: <Widget>[
                      Text(e.name),
                      SizedBox(width: 4),
                      Text(
                        "[${e.fromLanguage.value}${e.toLanguage != null ? "-${e.toLanguage!.value}" : ""}]",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
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
