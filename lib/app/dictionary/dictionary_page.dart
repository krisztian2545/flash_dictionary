import 'package:flash_dictionary/app/dictionary/dictionary_appbar.dart';
import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/dictionary/history/history_view.dart';
import 'package:flash_dictionary/app/dictionary/result/result_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> with AutomaticKeepAliveClientMixin {
  final double _appBarBaseHeight = 120;

  @override
  Widget build(BuildContext context) {
    super.build(context); // for keepAlive

    var appBarHeight = _appBarBaseHeight + MediaQuery.of(context).viewPadding.top;
    // print("appBarHeight: $appBarHeight");
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
                  : ResultView(appBarHeight: appBarHeight), // last on top
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}