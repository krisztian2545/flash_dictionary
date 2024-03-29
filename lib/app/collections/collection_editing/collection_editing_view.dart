import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_bloc.dart';
import 'package:flash_dictionary/app/collections/collection_editing/collection_editing_view_item.dart';
import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionEditingView extends StatelessWidget {
  const CollectionEditingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionEditingBloc bloc = Provider.of<CollectionEditingBloc>(context, listen: false);

    return FutureBuilder<List<LanguageCard>>(
      future: bloc.getLanguageCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.isEmpty) {
            return const Center(
                child: Text("No data!"));
          }

          print("cards: ${snapshot.data}");
          List<LanguageCard> cards = snapshot.data?.reversed.toList() ?? <LanguageCard>[];
          return ListView.separated(
            padding: const EdgeInsets.all(32),
            itemCount: cards.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, index) => CollectionEditingViewItem(
              languageCard: cards[index],
              collectionEditingBloc: bloc,
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
