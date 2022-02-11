import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/dictionary/result/definition_item_view.dart';
import 'package:flash_dictionary/app/dictionary/result/result_bloc.dart';
import 'package:flash_dictionary/app/dictionary/result/translation_item_view.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultView extends StatelessWidget {
  const ResultView({Key? key, required this.appBarHeight}) : super(key: key);

  final double appBarHeight;



  Widget _buildDefinitions(List<DefinitionItem> definitions) {
    if (definitions.isEmpty) {
      return const NotFoundSliverText();
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return DefinitionItemView(definitionItem: definitions[index]);
        },
        childCount: definitions.length,
      ),
    );
  }

  Widget _buildTranslations(List<TranslationItem> translations) {
    if (translations.isEmpty) {
      return const NotFoundSliverText();
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return TranslationItemView(translationItem: translations[index]);
        },
        childCount: translations.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: appBarHeight,
      left: 0,
      right: 0,
      bottom: 0,
      child: Material(
        color: whitishColor,
        clipBehavior: Clip.antiAlias,
        elevation: 16,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(46)),
        ),
        child: ChangeNotifierProvider<ResultBloc>(
          create: (context) => ResultBloc(),
          child: FutureBuilder<Map<String, dynamic>>(
            future:
                Provider.of<DictionaryBloc>(context, listen: false).fetchData(),
            builder: (context, snapshot) {
              var isDataLoaded =
                  snapshot.connectionState == ConnectionState.done;

              return Consumer<ResultBloc>(
                builder: (BuildContext context, ResultBloc resultBloc,
                    Widget? child) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        title: Text("Definition"),
                      ),
                      if (resultBloc.showDefinitions && isDataLoaded)
                        _buildDefinitions(snapshot.data!['definitions']),
                      SliverAppBar(
                        title: Text("Translation"),
                      ),
                      if (resultBloc.showTranslations && isDataLoaded)
                        _buildTranslations(snapshot.data!['translations']),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class NotFoundSliverText extends StatelessWidget {
  const NotFoundSliverText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          Container(
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            child: const Center(child: Text("Not found!")),
          ),
        ]));
  }
}
