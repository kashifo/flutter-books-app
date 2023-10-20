import 'dart:convert';
import 'dart:math';

import 'package:books_app/utils/commons.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:books_app/ui/item_book_grid.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ui/item_book_list.dart';

List<String> queries = ['Walter Isaacson', 'Paulo Coelho', 'Dale Carnegie', 'Robert Greene'];
String query = queries[ Random().nextInt(queries.length-1) ];

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<StatefulWidget> createState() {
    return DiscoverState();
  }
}

class DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover', style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w600),),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: FutureBuilder<GBookList>(
        future: fetchBooks(http.Client()),
        builder: (context, snapshot) {
          if (query.isEmpty) {
            return const Center(
              child: Text('Search something'),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An error has occurred! \n\n ${snapshot.error}'),
            );
          } else if (snapshot.hasData &&
              snapshot.data?.items != null &&
              snapshot.data!.items!.isNotEmpty) {
            return BooksGrid(gBookList: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<GBookList> fetchBooks(http.Client client) async {
  print('---fetchBooks()---');
  if (!query.isEmpty) {
    final response = await client.get(Uri.parse( getSearchUrl(query) ));

    print('fetchBooks response=${response.body}');

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseBooks, response.body);
  } else {
    return GBookList();
  }
}

// A function that converts a response body into a List<GBookList>.
GBookList parseBooks(String responseBody) {
  print('---parseBooks()---');

  final parsed_json = jsonDecode(responseBody);
  print('parsed_json=$parsed_json');

  final parsed_gbookList = GBookList.fromJson(parsed_json);
  print('parsed_gbookList=${parsed_gbookList.toString()}');

  return parsed_gbookList;
}


