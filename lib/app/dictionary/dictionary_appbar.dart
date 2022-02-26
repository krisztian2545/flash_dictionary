import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/widgets/language_dropdown_button.dart';
import 'package:flash_dictionary/app/widgets/word_dialog.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';

class DictionaryAppBar extends StatefulWidget {
  const DictionaryAppBar(
      {Key? key, required this.height, required this.dictionaryBloc})
      : super(key: key);

  final double height;
  final DictionaryBloc dictionaryBloc;

  @override
  State<DictionaryAppBar> createState() => _DictionaryAppBarState();
}

class _DictionaryAppBarState extends State<DictionaryAppBar> {
  List<Widget> _addButton() {
    var out = <Widget>[];

    if (widget.dictionaryBloc.wordToTranslate != "") {
      out.add(const SizedBox(width: 8));
      out.add(OutlinedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => WordDialog(
                    title: "Add word to collection",
                    initialFront: widget.dictionaryBloc.wordToTranslate,
                    definitions: widget.dictionaryBloc.lastFetchedDefinitions,
                    translations:
                        widget.dictionaryBloc.lastFetchedTranslationItems,
                  )).then((value) {
            if (value == null) {
              return;
            }
            widget.dictionaryBloc.saveWordToCollection(
                value['collectionDetails'], value['languageCard']);
          });
        },
        child: const Text("Add",
            style: TextStyle(color: Colors.black, fontSize: 20)),
        style: OutlinedButton.styleFrom(
            side: BorderSide(width: 2), fixedSize: Size.fromHeight(60)),
      ));
    }

    return out;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: widget.height,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                LanguageDropdownButton(
                  onChanged: (value) {
                    widget.dictionaryBloc.fromLanguage = value!;
                  },
                  value: widget.dictionaryBloc.fromLanguage,
                ),
                TextButton(
                  onPressed: () {
                    widget.dictionaryBloc.switchLanguages();
                  },
                  child: Text("<>", style: appBarButtonTextStyle),
                ),
                LanguageDropdownButton(
                  onChanged: (value) {
                    widget.dictionaryBloc.toLanguage = value!;
                  },
                  value: widget.dictionaryBloc.toLanguage,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 42),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: AutocompleteTextField(
                        dictionaryBloc: widget.dictionaryBloc),
                  ),
                  ..._addButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AutocompleteTextField extends StatelessWidget {
  const AutocompleteTextField({Key? key, required this.dictionaryBloc})
      : super(key: key);

  static const List<String> _kOptions = <String>[];
  final DictionaryBloc dictionaryBloc;

  void updateWordInBloc(BuildContext context, String word) {
    print(word);
    dictionaryBloc.wordToTranslate = word;
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
        updateWordInBloc(context, selection);
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onEditingComplete) {
        textEditingController.text =
            dictionaryBloc.wordToTranslate; // initial value
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                textEditingController.clear();
                updateWordInBloc(context, "");
              },
            ),
          ),
          onEditingComplete: () {
            updateWordInBloc(context, textEditingController.text);
            HiveHelper.saveWordInHistory(
                dictionaryBloc.wordToTranslate,
                dictionaryBloc.fromLanguage,
                dictionaryBloc.toLanguage,
                dictionaryBloc.translationApi);
            focusNode.unfocus();
            onEditingComplete();
          },
          onChanged: (value) {
            // if (value == "") {
            //   updateWordInBloc(context, "");
            // }
          },
        );
      },
    );
  }
}
