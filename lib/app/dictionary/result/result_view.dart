import 'dart:convert';

import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flash_dictionary/app/dictionary/result/result_bloc.dart';
import 'package:flash_dictionary/app/dictionary/result/translation_view.dart';
import 'package:flash_dictionary/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ResultView extends StatelessWidget {
  const ResultView({Key? key, required this.appBarHeight}) : super(key: key);

  final double appBarHeight;

  Future<dynamic> _getData(BuildContext context) async {
    final dictionaryBloc = Provider.of<DictionaryBloc>(context, listen: false);

    http.Response res = await http.get(
        Uri.parse(
            "https://link-bilingual-dictionary.p.rapidapi.com/eng/hun/${dictionaryBloc.wordToTranslate}"),
        headers: {
          "x-rapidapi-key":
              "ce00069c30msh4cb29af9cfca0f7p1a3af7jsn38922cb7f89a",
          "x-rapidapi-host": "link-bilingual-dictionary.p.rapidapi.com",
          "useQueryString": "true",
        });

    print("status code: ${res.statusCode} body: ${res.body}");

    return jsonDecode(res.body);
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
          child: FutureBuilder<dynamic>(
            future: _getData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text("Definition"),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                        Container(
                          child: Text("asdfasdf"),
                        ),
                      ]),
                    ),
                    SliverAppBar(
                      title: Text("Translation"),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Text(snapshot.data["results"][index]["word"]);
                          },
                        childCount: snapshot.data["results"].length,
                      ),
                    ),
                  ],
                );
              }

              return Center(child: Text("loading..."));
            },
          ),
        ),
      ),
    );
  }
}
