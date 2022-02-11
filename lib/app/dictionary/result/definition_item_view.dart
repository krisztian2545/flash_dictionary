import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flutter/material.dart';

class DefinitionItemView extends StatelessWidget {
  const DefinitionItemView({Key? key, required this.definitionItem})
      : super(key: key);

  final DefinitionItem definitionItem;

  List<Widget> _buildExamples(List<String> examples) {
    return examples.map((e) => Text(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Defintion:"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("[${definitionItem.partOfSpeech}]"),
              SizedBox(width: 8),
              Expanded(
                  child: Text(
                definitionItem.defintion,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              )),
            ],
          ),
          if (definitionItem.examples.isNotEmpty) Text("Examples"),
          ..._buildExamples(definitionItem.examples),
        ],
      ),
    );
  }
}
