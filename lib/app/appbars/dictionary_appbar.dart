import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

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
                      child: Form(
                        key: _formKey,
                        // autovalidateMode: AutovalidateMode.,
                        onChanged: () {
                          print("form onChanged: ${_textFieldController.text}");
                        },
                        child: SearchField( // what if i extend the lib with onEditingComplete?
                          controller: _textFieldController,
                          suggestions: ['Coming soon', 'ilasuhed'],
                          textInputAction: TextInputAction.send,
                        ),
                      ),
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
