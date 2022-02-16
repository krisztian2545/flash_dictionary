import 'package:flash_dictionary/app/dictionary/dictionary_appbar.dart';
import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/dictionary/history/history_view.dart';
import 'package:flash_dictionary/app/dictionary/result/result_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  final double _appBarBaseHeight = 150;

  @override
  Widget build(BuildContext context) {
    var appBarHeight = _appBarBaseHeight + MediaQuery.of(context).viewPadding.top;
    print("appBarHeight: $appBarHeight");
    return ChangeNotifierProvider<DictionaryBloc>(
      create: (context) => DictionaryBloc(),
      child: Consumer<DictionaryBloc>(
        builder: (BuildContext context, DictionaryBloc dictionaryBloc,
            Widget? child) {
          return Stack(
            children: <Widget>[
              DictionaryAppBar(height: appBarHeight, dictionaryBloc: dictionaryBloc),
              (dictionaryBloc.wordToTranslate == "")
                  ? HistoryView(appBarHeight: appBarHeight)
                  : ResultView(appBarHeight: appBarHeight),
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
