import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';

class MinigameShowFrontView extends StatelessWidget {
  const MinigameShowFrontView(
      {Key? key, required this.front, required this.onShowAnswerButtonPressed})
      : super(key: key);

  final String front;
  final VoidCallback onShowAnswerButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          front,
          style: appBarTextStyle,
        ),
        const Spacer(),
        OutlinedButton(
          onPressed: onShowAnswerButtonPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: borderWidth),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          ),
          child: const Text(
            "Show answer",
            style: appBarButtonTextStyle,
          ),
        ),
      ],
    );
  }
}
