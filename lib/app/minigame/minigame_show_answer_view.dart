import 'package:flash_dictionary/app/minigame/game_card_feedback_buttons.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';

class MinigameShowAnswerView extends StatelessWidget {
  const MinigameShowAnswerView({Key? key, required this.front, required this.back}) : super(key: key);

  final String front;
  final String back;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 42),
        Text(
          front,
          style: appBarTextStyle,
        ),
        const Divider(
          thickness: 2,
          color: Colors.black,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: Text(
                back,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        const GameCardFeedbackButtons(),
      ],
    );
  }
}
