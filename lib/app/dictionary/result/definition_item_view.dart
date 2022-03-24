import 'package:flash_dictionary/colors.dart';
import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flutter/material.dart';

class DefinitionItemView extends StatelessWidget {
  const DefinitionItemView({Key? key, required this.definitionItem})
      : super(key: key);

  final DefinitionItem definitionItem;

  List<Widget> _buildExamples(List<String> examples) {
    List<Widget> out = <Widget>[];

    if (definitionItem.examples.isNotEmpty) {
      out.addAll(<Widget>[
        SizedBox(height: 8),
        Text("Examples", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        Container(
          padding: EdgeInsets.only(left: 8),
          child: Column(
            children: examples.map((e) => Text(e)).toList(),
          ),
        ),
      ]);
    }

    return out;
  }

  @override
  Widget build(BuildContext context) {
    var textBoxWidth = MediaQuery.of(context).size.width - 32; // 2 * padding

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Defintion:", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          LimitedBox(
            maxWidth: textBoxWidth,
            child: Container(
              padding: EdgeInsets.only(left: 8),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: "[${definitionItem.partOfSpeech}] ", style: TextStyle(color: pastelGreen, fontWeight: FontWeight.w600)),
                    TextSpan(text: definitionItem.defintion),
                  ],
                ),
              ),
            ),
          ),
          ..._buildExamples(definitionItem.examples),
        ],
      ),
    );
  }
}
