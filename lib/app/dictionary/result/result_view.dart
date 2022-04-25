import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/dictionary/result/ResultViewFlexibleSpaceBar.dart';
import 'package:flash_dictionary/app/dictionary/result/definition_item_view.dart';
import 'package:flash_dictionary/app/dictionary/result/translation_item_view.dart';
import 'package:flash_dictionary/app/widgets/positioned_material.dart';
import 'package:flash_dictionary/domain/dictionary/definition_item.dart';
import 'package:flash_dictionary/domain/dictionary/translation_item.dart';
import 'package:flash_dictionary/service/storage_service.dart';
import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultView extends StatelessWidget {
  const ResultView({Key? key, required this.appBarHeight}) : super(key: key);

  final double appBarHeight;

  @override
  Widget build(BuildContext context) {
    return PositionedMaterial(
      appBarHeight: appBarHeight,
      child: FutureBuilder<Map<String, dynamic>>(
        future:
        Provider.of<DictionaryBloc>(context, listen: false).fetchData(), // TODO move future calls out of build method and use variables
        builder: (context, snapshot) {
          return ResultViewBuilder(
            isDataLoaded: snapshot.connectionState == ConnectionState.done,
            data: snapshot.data ?? {},
          );
        },
      ),
    );
  }
}

class ResultViewBuilder extends StatefulWidget {
  const ResultViewBuilder(
      {Key? key, required this.isDataLoaded, required this.data})
      : super(key: key);

  final bool isDataLoaded;
  final Map<String, dynamic> data;

  @override
  _ResultViewBuilderState createState() => _ResultViewBuilderState();
}

class _ResultViewBuilderState extends State<ResultViewBuilder> {
  late bool _showDefinitions;
  late bool _showTranslations;

  void toggleShowDefinitions() {
    _showDefinitions = !_showDefinitions;
    StorageService.saveLastShowDefinitionsState(_showDefinitions);
    setState(() {});
  }

  void toggleShowTranslations() {
    _showTranslations = !_showTranslations;
    StorageService.saveLastShowTranslationsState(_showTranslations);
    setState(() {});
  }

  @override
  void initState() {
    _showDefinitions = StorageService.getLastShowDefinitionsState();
    _showTranslations = StorageService.getLastShowTranslationsState();
    super.initState();
  }

  // Widget _buildContent() {
  //
  // }

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
    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: <Widget>[
        SliverAppBar(
          // pinned: true,
          flexibleSpace: ResultViewFlexibleSpaceBar(
            title: "Definitions",
            arrowFaceDown: _showDefinitions,
            onPressed: toggleShowDefinitions,
          ),
          shape: resultViewSliverAppBarBorder,
          toolbarHeight: 32,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white70,
        ),
        if (_showDefinitions && widget.isDataLoaded)
          _buildDefinitions(widget.data['definitions']),
        SliverAppBar(
          // pinned: true,
          flexibleSpace: ResultViewFlexibleSpaceBar(
            title: "Translation",
            arrowFaceDown: _showTranslations,
            onPressed: toggleShowTranslations,
          ),
          shape: resultViewSliverAppBarBorder,
          toolbarHeight: 32,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white70,
        ),
        if (_showTranslations && widget.isDataLoaded)
          _buildTranslations(widget.data['translations']),
      ],
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
