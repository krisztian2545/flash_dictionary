import 'package:flash_dictionary/app/minigame/minigame_appbar.dart';
import 'package:flash_dictionary/app/minigame/minigame_bloc.dart';
import 'package:flash_dictionary/app/minigame/minigame_view.dart';
import 'package:flash_dictionary/app/widgets/positioned_material.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/minigame/game_card.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinigamePage extends StatelessWidget {
  const MinigamePage({Key? key, required this.collectionDetails})
      : super(key: key);

  static const _appBarBaseHeight = 60;

  final CollectionDetails collectionDetails;

  Future<List<GameCard>> _loadData() async {
    return await HiveHelper.getGameCardsFromCollection(collectionDetails);
  }

  @override
  Widget build(BuildContext context) {
    var appBarHeight =
        _appBarBaseHeight + MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: primaryColor,
      body: FutureBuilder<List<GameCard>>(
        future: _loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ChangeNotifierProvider<MinigameBloc>(
              create: (_) => MinigameBloc(
                  collectionDetails: collectionDetails,
                  gameCards: snapshot.data!),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: appBarHeight,
                    child: MinigameAppbar(),
                  ),
                  PositionedMaterial(
                    appBarHeight: appBarHeight,
                    child: Consumer<MinigameBloc>(
                      builder: (context, bloc, child) {
                        return MinigameView();
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
