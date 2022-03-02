import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_bloc.dart';
import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_view_item.dart';
import 'package:flash_dictionary/domain/minigame/language_card.dart';
import 'package:flash_dictionary/service/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionEditingView extends StatelessWidget {
  const CollectionEditingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LanguageCard>>(
      future: HiveHelper.getLanguageCardsFromCollection(
          Provider.of<CollectionEditingBloc>(context, listen: false)
              .collectionDetails),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.isEmpty) {
            return Center(
                child: Text("No data!")); // TODO create no data widget
          }

          print("cards: ${snapshot.data}");
          return ListView.separated(
            padding: const EdgeInsets.all(32),
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, index) =>
                CollectionEditingViewItem(languageCard: snapshot.data![index]),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
