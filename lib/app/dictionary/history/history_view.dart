import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/dictionary/history/HistoryItemView.dart';
import 'package:flash_dictionary/app/widgets/positioned_material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key, required this.appBarHeight}) : super(key: key);

  final double appBarHeight;

  List<Widget> _buildList(BuildContext context) {
    return Provider.of<DictionaryBloc>(context, listen: false)
        .getWordHistory()
        .map((e) => HistoryItemView(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return PositionedMaterial(
      appBarHeight: appBarHeight,
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        children: _buildList(context),
      ),
    );
  }
}
