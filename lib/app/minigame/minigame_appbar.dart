import 'package:flash_dictionary/app/minigame/minigame_bloc.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinigameAppbar extends StatelessWidget {
  const MinigameAppbar({Key? key}) : super(key: key);

  void _onBackButtonPressed(BuildContext context) {
    // Provider.of<MinigameBloc>(context, listen: false).close(); // TODO do I need this if I close in dispose?
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          IconButton(
              onPressed: () => _onBackButtonPressed(context),
              icon: const Icon(Icons.arrow_back_sharp)),
          const SizedBox(width: 16),
          Text(
            Provider.of<MinigameBloc>(context, listen: false).collectionDetails.name,
            style: appBarTextStyle,
          ),
        ],
      ),
    );
  }
}
