import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/dictionary/history/HistoryItemView.dart';
import 'package:flash_dictionary/colors.dart';
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
    return Positioned(
      top: appBarHeight,
      left: 0,
      right: 0,
      bottom: 0,
      child: Material(
        color: whitishColor,
        clipBehavior: Clip.antiAlias,
        elevation: 16,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(46)),
        ),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          children: _buildList(context),
        ),
      ),
    );
  }
}
