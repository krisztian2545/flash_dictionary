import 'package:flash_dictionary/app/dictionary/history/HistoryItemView.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key, required this.appBarHeight}) : super(key: key);

  final double appBarHeight;

  List<Widget> _buildList() {
    return HiveHelper.getWordHistory().map((e) { // TODO move this to a bloc
      var wordData = e.split(";");
      var langData = wordData[1].split("-");
      return HistoryItemView(word: wordData[0], fromLanguage: langData[0], toLanguage: langData[1], api: wordData[2]);
    }).toList().reversed.toList();
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
          children: _buildList(),
        ),
      ),
    );
  }
}
