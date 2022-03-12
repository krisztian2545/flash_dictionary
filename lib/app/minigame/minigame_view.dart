import 'package:flash_dictionary/app/minigame/game_card_feedback_buttons.dart';
import 'package:flash_dictionary/app/minigame/minigame_bloc.dart';
import 'package:flash_dictionary/app/minigame/show_answer_button.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinigameView extends StatefulWidget {
  const MinigameView({Key? key}) : super(key: key);

  @override
  _MinigameViewState createState() => _MinigameViewState();
}

class _MinigameViewState extends State<MinigameView> {
  bool showAnswer = false;
  bool isGameOver = false;
  late final MinigameBloc minigameBloc;

  void initRound() {
    if (minigameBloc.pickRandomCard()) {
      setState(() {
        showAnswer = false;
      });
      return;
    }
    setState(() {
      isGameOver = true;
    });
  }

  @override
  void initState() {
    print("new card");
    minigameBloc = Provider.of<MinigameBloc>(context, listen: false);
    initRound();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MinigameView oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didupdatewidget....");

    initRound();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isGameOver) {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Congratulations!", style: appBarTextStyle,),
              Text("You learned all the cards", style: appBarTextStyle,),
            ],
          ),
        ),
      );
    }

    List<Widget> upperPart;
    List<Widget> bottomPart;

    if (showAnswer) {
      upperPart = <Widget>[
        const SizedBox(height: 42),
        Text(minigameBloc.currentGameCard.card.front, style: appBarTextStyle,),
        const Divider(thickness: 2, color: Colors.black,),
        const Spacer(),
        Text(minigameBloc.currentGameCard.card.back, style: appBarTextStyle.copyWith(fontWeight: FontWeight.normal),),
      ];
      bottomPart = <Widget>[
        GameCardFeedbackButtons()
      ];

    } else {
      upperPart = <Widget>[
        const Spacer(),
        Text(minigameBloc.currentGameCard.card.front, style: appBarTextStyle,),
      ];
      bottomPart = <Widget>[
        ShowAnswerButton(
          onPressed: () => setState(() {
            showAnswer = true;
          }),
        ),
      ];
    }

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          ...upperPart,
          const Spacer(),
          ...bottomPart,
        ],
      ),
    );
  }

  @override
  void dispose() {
    print("disposing minigame view...");
    minigameBloc.saveData();
    super.dispose();
  }
}
