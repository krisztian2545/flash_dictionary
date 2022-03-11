import 'package:flash_dictionary/app/minigame/minigame_bloc.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameCardFeedbackButtons extends StatelessWidget {
  const GameCardFeedbackButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MinigameBloc minigameBloc = Provider.of<MinigameBloc>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        OutlinedButton(
          onPressed: () => minigameBloc.giveFeedback(CardDifficulty.hard),
          style: OutlinedButton.styleFrom(side: BorderSide(width: 2)),
          child: const Text("Hard", style: appBarButtonTextStyle,),
        ),
        OutlinedButton(
          onPressed: () => minigameBloc.giveFeedback(CardDifficulty.medium),
          style: OutlinedButton.styleFrom(side: BorderSide(width: 2)),
          child: const Text("Medium", style: appBarButtonTextStyle,),
        ),
        OutlinedButton(
          onPressed: () => minigameBloc.giveFeedback(CardDifficulty.easy),
          style: OutlinedButton.styleFrom(side: BorderSide(width: 2)),
          child: const Text("Easy" ,style: appBarButtonTextStyle,),
        ),
      ],
    );
  }
}
