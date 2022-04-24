import 'package:flash_dictionary/app/minigame/minigame_bloc.dart';
import 'package:flash_dictionary/app/minigame/minigame_show_answer_view.dart';
import 'package:flash_dictionary/app/minigame/minigame_show_front_view.dart';
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
    setState(() {}); // TODO do I need this?
  }

  @override
  Widget build(BuildContext context) {
    if (isGameOver) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Congratulations!\nYou learned all the cards",
            textAlign: TextAlign.center,
            style: appBarTextStyle,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Return to main menu."),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: showAnswer
          ? MinigameShowAnswerView(
              front: minigameBloc.currentGameCard.card.front,
              back: minigameBloc.currentGameCard.card.back,
            )
          : MinigameShowFrontView(
              front: minigameBloc.currentGameCard.card.front,
              onShowAnswerButtonPressed: () => setState(() {
                showAnswer = true;
              }),
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
