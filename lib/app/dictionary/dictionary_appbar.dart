import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/widgets/language_dropdown_button.dart';
import 'package:flash_dictionary/app/widgets/word_dialog.dart';
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
  void _onAddButtonPressed() {
    // TODO make it appear after data is fetched
    if (widget.dictionaryBloc.lastFetchedDefinitions == null ||
        widget.dictionaryBloc.lastFetchedTranslationItems == null) {
      return;
    }

    showDialog(
        context: context,
        builder: (context) => WordDialog(
              initialFront: widget.dictionaryBloc.wordToTranslate,
              definitions: widget.dictionaryBloc.lastFetchedDefinitions,
              translations: widget.dictionaryBloc.lastFetchedTranslationItems,
              fromLanguage: widget.dictionaryBloc.fromLanguage,
              toLanguage: widget.dictionaryBloc.toLanguage,
            )).then((value) {
      if (value == null) {
        return;
      }
      widget.dictionaryBloc.saveWordToCollection(
          value['collectionDetails'], value['languageCard']);
    });
  }

  List<Widget> _addButton() {
    var out = <Widget>[];

    if (widget.dictionaryBloc.wordToTranslate != "") {
      out.add(const SizedBox(width: 8));
      out.add(OutlinedButton(
        onPressed: _onAddButtonPressed,
        child: const Text("Add",
            style: TextStyle(color: Colors.black, fontSize: 20)),
        style: OutlinedButton.styleFrom(
            side: BorderSide(width: borderWidth),
            fixedSize: Size.fromHeight(60)),
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
                    widget.dictionaryBloc.switchFromLanguageTo(value!);
                  },
                  value: widget.dictionaryBloc.fromLanguage,
                ),
                TextButton(
                  onPressed: () {
                    widget.dictionaryBloc.switchToLanguageTo(widget.dictionaryBloc.fromLanguage);
                  },
                  child: Text("<>", style: appBarButtonTextStyle),
                ),
                LanguageDropdownButton(
                  onChanged: (value) {
                    widget.dictionaryBloc.switchToLanguageTo(value!);
                  },
                  value: widget.dictionaryBloc.toLanguage,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 60),
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
        dictionaryBloc.searchForWord(selection);
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onEditingComplete) {
        textEditingController.text =
            dictionaryBloc.wordToTranslate; // initial value

        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          autofocus: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: borderWidth, color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: borderWidth, color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                textEditingController.clear();
                dictionaryBloc.clearText();
              },
            ),
          ),
          onEditingComplete: () {
            dictionaryBloc.searchForWord(textEditingController.text);
            focusNode.unfocus();
            onEditingComplete();
          },
        );
      },
    );
  }
}
