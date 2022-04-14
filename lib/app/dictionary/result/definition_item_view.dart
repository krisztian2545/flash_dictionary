import 'package:flash_dictionary/colors.dart';
import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flutter/material.dart';

class DefinitionItemView extends StatelessWidget {
  const DefinitionItemView({Key? key, required this.definitionItem})
      : super(key: key);

  final DefinitionItem definitionItem;

  List<Widget> _buildExamples(List<String> examples) => <Widget>[
    const SizedBox(height: 8),
    const Text("Examples",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
    Container(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: examples.map((e) => Text("$e;")).toList(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var textBoxWidth = MediaQuery.of(context).size.width - 32; // 2 * padding

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Defintion:",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          LimitedBox(
            maxWidth: textBoxWidth,
            child: Container(
              padding: const EdgeInsets.only(left: 8),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "[${definitionItem.partOfSpeech}] ",
                        style: const TextStyle(
                            color: pastelGreen, fontWeight: FontWeight.w600)),
                    TextSpan(text: definitionItem.defintion),
                  ],
                ),
              ),
            ),
          ),
          // ..._buildExamples(definitionItem.examples),
          if (definitionItem.examples.isNotEmpty)
            ..._buildExamples(definitionItem.examples),
        ],
      ),
    );
  }
}
