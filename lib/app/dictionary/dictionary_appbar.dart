import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/widgets/language_dropdown_button.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final ValueNotifier<bool> _languageValueNotifier = ValueNotifier<bool>(false);

  void triggerLanguageButtonRebuilds() {
    _languageValueNotifier.value = !_languageValueNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: widget.height,
      child: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                // color: Colors.blue,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _languageValueNotifier,
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        // TextButton(
                        //     onPressed: () {},
                        //     child: Text("English", style: appBarButtonTextStyle)),
                        LanguageDropdownButton(
                          onChanged: (value) {
                            if (widget.dictionaryBloc.toLanguage == value) {
                              widget.dictionaryBloc.switchLanguages();
                            } else {
                              widget.dictionaryBloc.fromLanguage = value!;
                            }
                            triggerLanguageButtonRebuilds();
                          },
                          value: widget.dictionaryBloc.fromLanguage,
                        ),
                        TextButton(
                          onPressed: () {
                            widget.dictionaryBloc.switchLanguages();
                            triggerLanguageButtonRebuilds();
                          },
                          child: Text("<>", style: appBarButtonTextStyle),
                        ),
                        LanguageDropdownButton(
                          onChanged: (value) {
                            if (widget.dictionaryBloc.fromLanguage == value) {
                              widget.dictionaryBloc.switchLanguages();
                            } else {
                              widget.dictionaryBloc.toLanguage = value!;
                            }
                            triggerLanguageButtonRebuilds();
                          },
                          value: widget.dictionaryBloc.toLanguage,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                // color: Colors.green,
                padding: EdgeInsets.only(left: 8, right: 42),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AutocompleteTextField(
                          dictionaryBloc: widget.dictionaryBloc),
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
        textEditingController.text =
            dictionaryBloc.wordToTranslate; // initial value
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
