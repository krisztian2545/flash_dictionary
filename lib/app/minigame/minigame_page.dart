import 'package:flash_dictionary/app/minigame/minigame_appbar.dart';
import 'package:flash_dictionary/app/minigame/minigame_bloc.dart';
import 'package:flash_dictionary/app/minigame/minigame_view.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinigamePage extends StatelessWidget {
  const MinigamePage({Key? key, required this.collectionDetails})
      : super(key: key);

  static const _appBarBaseHeight = 60;

  final CollectionDetails collectionDetails;

  @override
  Widget build(BuildContext context) {
    var appBarHeight =
        _appBarBaseHeight + MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: primaryColor,
      body: ChangeNotifierProvider<MinigameBloc>(
        create: (_) => MinigameBloc(collectionDetails: collectionDetails),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: appBarHeight,
              child: MinigameAppbar(),
            ),
            Positioned(
              top: appBarHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: Material(
                child: MinigameView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
