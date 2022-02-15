import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/domain/dictionary/language_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryItemView extends StatelessWidget {
  const HistoryItemView(
      {Key? key,
      required this.word,
      required this.fromLanguage,
      required this.toLanguage,
      required this.api})
      : super(key: key);

  final String word;
  final String fromLanguage;
  final String toLanguage;
  final String api;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var bloc = Provider.of<DictionaryBloc>(context, listen: false);
        bloc.fromLanguage = languageNameFromString(fromLanguage);
        bloc.toLanguage = languageNameFromString(toLanguage);
        bloc.wordToTranslate = word;
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Text(word, style: const TextStyle(fontSize: 20)),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
