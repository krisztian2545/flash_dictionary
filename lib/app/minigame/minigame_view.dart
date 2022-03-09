import 'package:flash_dictionary/app/minigame/minigame_bloc.dart';
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
    minigameBloc = Provider.of<MinigameBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!showAnswer) Spacer(),
        Column(
          children: <Widget>[
            Text("hjkasgdfkjhagsdf"),
            if (showAnswer) Text("hjklasdf"),
          ],
        ),
        Spacer(),
        OutlinedButton(
          onPressed: () {
            setState(() {
              showAnswer = !showAnswer;
            });
          },
          child: Text("Show answer"),
        ),
      ],
    );
  }
}
