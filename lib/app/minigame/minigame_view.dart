import 'package:flutter/material.dart';

class MinigameView extends StatefulWidget {
  const MinigameView({Key? key}) : super(key: key);

  @override
  _MinigameViewState createState() => _MinigameViewState();
}

class _MinigameViewState extends State<MinigameView> {
  bool showAnswer = false;

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
        OutlinedButton(onPressed: () {setState(() {
          showAnswer = !showAnswer;
        });}, child: Text("Show answer")),
      ],
    );
  }
}
