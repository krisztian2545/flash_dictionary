import 'package:flash_dictionary/app/minigame/game_card_feedback_buttons.dart';
import 'package:flash_dictionary/app/minigame/minigame_bloc.dart';
import 'package:flash_dictionary/app/minigame/show_answer_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinigameView extends StatefulWidget {
  const MinigameView({Key? key}) : super(key: key);

  @override
  _MinigameViewState createState() => _MinigameViewState();
}

class _MinigameViewState extends State<MinigameView> {
  bool showAnswer = false;
  late final MinigameBloc minigameBloc;

  @override
  void initState() {
    print("new card");
    minigameBloc = Provider.of<MinigameBloc>(context, listen: false);
    minigameBloc.pickRandomCard();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MinigameView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didupdatewidget....");
    setState(() {
      minigameBloc.pickRandomCard();
      showAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> upperPart;
    List<Widget> bottomPart;

    if (showAnswer) {
      upperPart = <Widget>[
        Text(minigameBloc.currentGameCard.card.front),
        const Spacer(),
        Text(minigameBloc.currentGameCard.card.back),
      ];
      bottomPart = <Widget>[
        GameCardFeedbackButtons()
      ];

    } else {
      upperPart = <Widget>[
        const Spacer(),
        Text(minigameBloc.currentGameCard.card.front),
      ];
      bottomPart = <Widget>[
        ShowAnswerButton(
          onPressed: () => setState(() {
            showAnswer = true;
          }),
        ),
      ];
    }

    return Column(
      children: [
        ...upperPart,
        const Spacer(),
        ...bottomPart,
      ],
    );
  }
}
