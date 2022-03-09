import 'package:flash_dictionary/app/minigame/minigame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameCardFeedbackButtons extends StatelessWidget {
  const GameCardFeedbackButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MinigameBloc minigameBloc = Provider.of<MinigameBloc>(context, listen: false);

    return Row(
      children: <Widget>[
        OutlinedButton(
          onPressed: () => minigameBloc.giveFeedback(CardDifficulty.hard),
          child: const Text("Hard"),
        ),
        OutlinedButton(
          onPressed: () => minigameBloc.giveFeedback(CardDifficulty.medium),
          child: const Text("Medium"),
        ),
        OutlinedButton(
          onPressed: () => minigameBloc.giveFeedback(CardDifficulty.easy),
          child: const Text("Easy"),
        ),
      ],
    );
  }
}
