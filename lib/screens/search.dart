import 'dart:convert';

import 'package:books_app/utils/commons.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../widgets/item_book_list.dart';

String query = '';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<StatefulWidget> createState() {
    return SearchState();
  }
}

class SearchState extends State<Search> {
  late http.Client httpClient;
  bool isFavLoading = false, isLoading = false;
  List<String> favList = [];

  @override
  void initState() {
    super.initState();
    httpClient = http.Client();
    fetchFavorites();
  }

  fetchFavorites() async {
    isFavLoading = true;

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
      isFavLoading = false;
      favList;
    });
  }

  @override
  void dispose() {
    httpClient.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Get.isDarkMode? Colors.grey.withOpacity(0.1) : Colors.black87.withOpacity(0.2),
                    blurRadius: 40,
                    spreadRadius: 0.0)
              ]
              ),
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: (queryInput) {
                  setState(() {
                    query = queryInput;
                  });
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Get.isDarkMode? Colors.black54 : Colors.white,
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'Type something to search',
                    hintStyle:
                    TextStyle(color: Get.isDarkMode? Colors.grey : Colors.black38, fontSize: 14),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.search, color: Get.isDarkMode? Colors.grey : Colors.black54,),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none)),
              ),
            ),

            Expanded(
              child: FutureBuilder<GBookList>(
                future: searchBooks(httpClient),
                builder: (context, snapshot) {

                  if(isLoading){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (query.isEmpty) {
                    return const Center(
                      child: Text('Type something to search'),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('An error has occurred! \n\n ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {

                    if(snapshot.data?.items!=null && snapshot.data!.items!.isNotEmpty) {
                      return BooksList(gBookList: snapshot.data!);
                    } else {
                      return const Center(
                        child: Text('No items found'),
                      );
                    }

                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                },
              ),
            ),
          ],
        ),
      ),
    );
  }//build


  Future<GBookList> searchBooks(http.Client client) async {
    print('---searchBooks()---$query');

    if (!query.isEmpty) {
      isLoading = true;
      final response = await client.get(Uri.parse(getSearchUrl(query)));
      //print('searchBooks response=${response.body}');

      // Use the compute function to run parser in a separate isolate.
      // return compute(parseBooks, response.body);
      isLoading = false;
      return await parseBooks(response.body);
    }

    isLoading = false;
    return GBookList();
  }

  // A function that converts a response body into a List<GBookList>.
  Future<GBookList> parseBooks(String responseBody) async {
    print('---parseBooks()---');

    final parsed_json = jsonDecode(responseBody);
    //print('parsed_json=$parsed_json');

    GBookList parsed_gbookList = GBookList.fromJson(parsed_json);

    if(parsed_gbookList.items!=null && parsed_gbookList.items!.isNotEmpty) {
      print('parsed_gbookList items len=${parsed_gbookList.items!.length}');

      for (var gbook in parsed_gbookList.items!) {
        if(favList.contains( gbook.id )){
          gbook.isFavorite = 1;
        }
      }

      return parsed_gbookList;
    }

    return Future.error('Something went wrong');
  }


}//SearchState