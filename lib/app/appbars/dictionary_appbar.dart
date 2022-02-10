import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DictionaryAppBar extends StatefulWidget {
  const DictionaryAppBar({Key? key, required this.height, required this.dictionaryBloc}) : super(key: key);

  final double height;
  final DictionaryBloc dictionaryBloc;

  @override
  State<DictionaryAppBar> createState() => _DictionaryAppBarState();
}

class _DictionaryAppBarState extends State<DictionaryAppBar> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();

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
                      child: AutocompleteTextField(),
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
  const AutocompleteTextField({Key? key}) : super(key: key);

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  void updateWordInBloc(BuildContext context, String word) {
    print(word);
    Provider.of<DictionaryBloc>(context, listen: false).wordToTranslate = word;
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
      fieldViewBuilder: (context, textEditingController, focusNode, onEditingComplete) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onEditingComplete: () {
            updateWordInBloc(context, textEditingController.text);
            focusNode.unfocus();
            onEditingComplete();
          },
          onChanged: (value) {
            if (value == "") {
              updateWordInBloc(context, "");
            }
          },
        );
      },
    );
  }
}