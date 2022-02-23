import 'package:flutter/material.dart';

class ResultViewFlexibleSpaceBar extends StatelessWidget {
  const ResultViewFlexibleSpaceBar({Key? key, required this.title, required this.arrowFaceDown, required this.onIconPressed}) : super(key: key);

  final String title;
  final VoidCallback onIconPressed;
  final bool arrowFaceDown;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontSize: 24)),
          Spacer(flex: 8),
          IconButton(
            padding: EdgeInsets.zero,
            iconSize: 32,
            onPressed: onIconPressed,
            icon: Icon(arrowFaceDown
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down),),
          Spacer(),
        ],
      ),
    );
  }
}
