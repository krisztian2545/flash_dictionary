import 'package:flash_dictionary/app/minigame/minigame_page.dart';
import 'package:flash_dictionary/domain/collections/collection_details.dart';
import 'package:flash_dictionary/domain/minigame/game_card.dart';
import 'package:flash_dictionary/service/storage_service.dart';
import 'package:flutter/material.dart';

class PlayMinigameButton extends StatelessWidget {
  const PlayMinigameButton({Key? key, required this.collectionDetails})
      : super(key: key);

  final CollectionDetails collectionDetails;

  void _onPressed(BuildContext context) {
    // TODO close box after game ended
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => MinigamePage(collectionDetails: collectionDetails)),
    );
  }

  Future<bool> isCollectionPlayable() async =>
      (await StorageService.getGameCardsFromCollection(collectionDetails))
          .isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isCollectionPlayable(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            (snapshot.data ?? false)) {
          return IconButton(
            onPressed: () => _onPressed(context),
            icon: const Icon(Icons.play_arrow_outlined, size: 38),
            padding: EdgeInsets.zero,
          );
        }

        return Container();
      },
    );
  }
}
