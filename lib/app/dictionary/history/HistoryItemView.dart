import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/widgets/word_dialog.dart';
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
  final String api; // TODO do I need this?

  Future<void> _onAddButtonPressed(BuildContext context) async {
    var data = await Provider.of<DictionaryBloc>(context, listen: false)
        .fetchData(word, languageNameFromString(fromLanguage),
            languageNameFromString(toLanguage));

    showDialog(
        context: context,
        builder: (context) => WordDialog(
              initialFront: word,
              definitions: data['definitions'],
              translations: data['translations'],
              fromLanguage: languageNameFromString(fromLanguage),
              toLanguage: languageNameFromString(toLanguage),
            )).then((value) {
      if (value == null) {
        return;
      }
      Provider.of<DictionaryBloc>(context, listen: false).saveWordToCollection(
          value['collectionDetails'], value['languageCard']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<DictionaryBloc>(context, listen: false).setWordAndLanguages(
            word,
            languageNameFromString(fromLanguage),
            languageNameFromString(toLanguage));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Text(word, style: const TextStyle(fontSize: 20)),
            const Spacer(),
            IconButton(
              onPressed: () => _onAddButtonPressed(context),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
