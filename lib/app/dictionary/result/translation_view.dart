import 'package:flash_dictionary/app/dictionary/dictionary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TranslationView extends StatelessWidget {
  const TranslationView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container();
  //   return FutureBuilder(
  //     future: _getData(context),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return SliverList(
  //           delegate: SliverChildListDelegate(<Widget>[
  //             Container(
  //               child: Text("data: "),
  //             ),
  //           ]),
  //         );
  //       }
  //
  //       return Text("loading...");
  //     },
  //   );
  }
}
