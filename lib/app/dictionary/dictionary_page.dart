import 'package:flash_dictionary/app/appbars/dictionary_appbar.dart';
import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/dictionary/history/history_view.dart';
import 'package:flash_dictionary/app/dictionary/result/result_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  final double _appBarHeight = 130;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DictionaryBloc>(
      create: (context) => DictionaryBloc(),
      child: Consumer<DictionaryBloc>(
        builder: (BuildContext context, DictionaryBloc dictionaryBloc,
            Widget? child) {
          return Stack(
            children: <Widget>[
              DictionaryAppBar(height: _appBarHeight, dictionaryBloc: dictionaryBloc),
              (dictionaryBloc.wordToTranslate == "")
                  ? HistoryView(appBarHeight: _appBarHeight)
                  : ResultView(appBarHeight: _appBarHeight),
            ],
          );
        },
      ),
    );
  }
}

// class DictionaryPageBody extends StatelessWidget {
//   const DictionaryPageBody({Key? key}) : super(key: key);
//
//   final
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
