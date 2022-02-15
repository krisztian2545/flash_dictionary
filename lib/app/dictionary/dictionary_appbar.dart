import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DictionaryAppBar extends StatelessWidget {
  const DictionaryAppBar(
      {Key? key, required this.height})
      : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                // color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {},
                        child: Text("English", style: appBarButtonTextStyle)),
                    // Spacer(),
                    Text("<>", style: appBarButtonTextStyle),
                    // Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text("Hungarian", style: appBarButtonTextStyle)),
                  ],
                ),
              ),
              Container(
                // color: Colors.green,
                padding: EdgeInsets.only(left: 8, right: 42),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AutocompleteTextField(dictionaryBloc: Provider.of<DictionaryBloc>(context, listen: false)),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
        textEditingController.text = dictionaryBloc.wordToTranslate; // initial value
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
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
