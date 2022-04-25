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

  late final MinigameBloc minigameBloc;
  late Future<void> initBloc;

  @override
  void initState() {
    print("new card");
    minigameBloc = Provider.of<MinigameBloc>(context, listen: false);
    initBloc = minigameBloc.init().then((value) => minigameBloc.initRound());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initBloc,
      builder: (context, snapshot) {
        print("building...");
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        return Consumer<MinigameBloc>(
          builder: (context, bloc, child) {
            print("building consumer...");

            if (bloc.isGameOver) {
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
              child: bloc.getShowAnswer
                  ? MinigameShowAnswerView(
                front: minigameBloc.currentGameCard.card.front,
                back: minigameBloc.currentGameCard.card.back,
              )
                  : MinigameShowFrontView(
                front: minigameBloc.currentGameCard.card.front,
                onShowAnswerButtonPressed: () => bloc.showAnswer(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    print("disposing minigame view...");
    minigameBloc.saveData();
    super.dispose();
  }
}
