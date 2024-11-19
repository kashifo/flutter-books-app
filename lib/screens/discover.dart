import 'dart:convert';
import 'dart:math';
import 'package:books_app/widgets/error_view.dart';
import 'package:books_app/utils/commons.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:books_app/widgets/item_book_grid.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/no_network.dart';


class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<StatefulWidget> createState() {
    return DiscoverState();
  }
}

class DiscoverState extends State<Discover> {
  List<String> favList = [];

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  fetchFavorites() async {
    var snapshot = await Firestore.instance
        .collection('users')
        .document( FirebaseAuth.instance.userId )
        .collection('favorites')
        .get();

    print('fetchFavorites len=${snapshot.toList().length}');
    var list = snapshot.toList();

    for (var favorite in list) {
      favList.add( favorite.id );
    }

    setState(() {
      favList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discover',
          style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<GBookList>(
        future: fetchBooks(),
        builder: (context, snapshot) {

          if (snapshot.hasError) {

            if (snapshot.error!=null) {
              var error = snapshot.error.toString();

              if(error.contains('SocketException')){
                return noNetworkWidget();
              } else if(error.contains('Quota Exceeded')){
                return errorViewWidget('API Free Quota Exceeded', 'Please try again tomorrow or get an API Key', '');
              } else {
                return errorViewWidget(
                    'Something went wrong',
                    'Please try again later, \nif error persists contact us.\n',
                    error.toString());
              }

            } else {
              return errorViewWidget(
                'Something went wrong',
                'Please try again later, \nif error persists contact us.\n',
                  '');
            }

          } else if (snapshot.hasData && snapshot.data?.items!=null && snapshot.data!.items!.isNotEmpty) {
            // print('builder snapshot hasData=${snapshot.data}');
            return BooksGrid(gBookList: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }//build

  Future<GBookList> fetchBooks() async {
    print('---fetchBooks()---');

    List<String> queries = [
      'Walter Isaacson',
      'Paulo Coelho',
      'Dale Carnegie',
      'Robert Greene'
    ];
    String query = queries[Random().nextInt(queries.length)];

    var uri = Uri.parse(getSearchUrl(query));
    print('fetchBooks uri=${uri.toString()}');

    final response = await http.Client().get(uri);
    // print('fetchBooks response=${response.body}');

    if (response.body.contains('error')) {
      if (response.body.contains('"code": 429')) {
        return Future.error('API Free Quota Exceeded');
      } else {
        return Future.error('Something went wrong');
      }
    } else {
      return await parseBooks(response.body);
    }

  }

  // A function that converts a response body into a List<GBookList>.
  Future<GBookList> parseBooks(String responseBody) async {
    print('---parseBooks()---');

    final parsed_json = jsonDecode(responseBody);
    print('parsed_json completed');
    // print('parsed_json=$parsed_json');

    final parsed_gbookList = GBookList.fromJson(parsed_json);

    if(parsed_gbookList.items!=null && parsed_gbookList.items!.isNotEmpty) {
      print('parsed_gbookList completed totalItems=${parsed_gbookList.totalItems}, items=${parsed_gbookList.items?.length}');

      for (var gbook in parsed_gbookList.items!) {
        if(favList.contains( gbook.id )){
          gbook.isFavorite = 1;
        }
      }

      return parsed_gbookList;
    }

    return Future.error('Something went wrong');
  }

}//State