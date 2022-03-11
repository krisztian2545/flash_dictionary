import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';

class ShowAnswerButton extends StatelessWidget {
  const ShowAnswerButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(side: BorderSide(width: 2)),
      child: const Text("Show answer", style: appBarButtonTextStyle,),
    );
  }
}
