import 'package:flutter/material.dart';

class ResultViewFlexibleSpaceBar extends StatelessWidget {
  const ResultViewFlexibleSpaceBar(
      {Key? key,
      required this.title,
      required this.arrowFaceDown,
      required this.onPressed})
      : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final bool arrowFaceDown;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
        splashFactory: NoSplash.splashFactory, // or maybe use GestureDetectorinstead of TextButton?
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 24)),
          const Spacer(flex: 8),
          Icon(
            arrowFaceDown ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 32,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
