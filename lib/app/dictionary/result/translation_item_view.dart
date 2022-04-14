import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flutter/material.dart';

class TranslationItemView extends StatelessWidget {
  const TranslationItemView({Key? key, required this.translationItem}) : super(key: key);

  final TranslationItem translationItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(translationItem.word),
    );
  }
}
