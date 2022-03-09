import 'package:flutter/material.dart';

class ShowAnswerButton extends StatelessWidget {
  const ShowAnswerButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: const Text("Show answer"),
    );
  }
}
