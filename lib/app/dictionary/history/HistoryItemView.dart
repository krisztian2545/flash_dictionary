import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/widgets/word_dialog.dart';
import 'package:flash_dictionary/domain/dictionary/word_with_params.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryItemView extends StatelessWidget {
  const HistoryItemView(this.wordWithParams, {Key? key}) : super(key: key);

  final WordWithParams wordWithParams;

  Future<void> _onAddButtonPressed(BuildContext context) async {
    DictionaryBloc dictionaryBloc =
        Provider.of<DictionaryBloc>(context, listen: false);
    var data = await dictionaryBloc.fetchDataWithParams(wordWithParams.word,
        wordWithParams.fromLanguage, wordWithParams.toLanguage);

    showDialog(
        context: context,
        builder: (context) => WordDialog(
              initialFront: wordWithParams.word,
              definitions: data['definitions'],
              translations: data['translations'],
              fromLanguage: wordWithParams.fromLanguage,
              toLanguage: wordWithParams.toLanguage,
            )).then((value) {
      if (value == null) {
        return;
      }
      dictionaryBloc.saveWordToCollection(
          value['collectionDetails'], value['languageCard']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<DictionaryBloc>(context, listen: false)
            .searchForWordWithParams(wordWithParams.word,
                wordWithParams.fromLanguage, wordWithParams.toLanguage);
      },
      child: Container(
        color: Colors.transparent, // this solved background not being detected by GestureDetector
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Text(wordWithParams.word, style: const TextStyle(fontSize: 20)),
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
