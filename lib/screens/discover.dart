import 'dart:convert';
import 'dart:math';

import 'package:books_app/widgets/error_view.dart';
import 'package:books_app/utils/commons.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:books_app/widgets/item_book_grid.dart';
// import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/GBook.dart';
import '../widgets/item_book_list.dart';
import '../widgets/no_network.dart';

List<String> queries = [
  'Walter Isaacson',
  'Paulo Coelho',
  'Dale Carnegie',
  'Robert Greene'
];
String query = queries[Random().nextInt(queries.length - 1)];

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
        title: const Text(
          'Discover',
          style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<GBookList>(
        future: fetchBooks(),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            var error = snapshot.error?.toString();

            if (error != null && error.contains('SocketException')) {
              return noNetworkWidget();
            } else {
              return errorViewWidget(
                  'Something went wrong',
                  'Please try again later, \nif error persists contact us.\n',
                  error?.toString());
            }

          } else if (snapshot.hasData && snapshot.data?.items!=null && snapshot.data!.items!.isNotEmpty) {
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

Future<GBookList> fetchBooks() async {
  print('---fetchBooks()---');
  if (!query.isEmpty) {
    var uri = Uri.parse(getSearchUrl(query));
    print('fetchBooks uri=${uri.toString()}');

    final response = await http.Client().get(uri);

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
  print('parsed_json completed');

  final parsed_gbookList = GBookList.fromJson(parsed_json);
  print('parsed_gbookList=${parsed_gbookList.toString()}');

  /*var dataBox = Hive.box('favorites');
  if(parsed_gbookList.items!=null && parsed_gbookList.items!.isNotEmpty) {
    for (GBook curBook in parsed_gbookList.items!) {
      var where = dataBox.get(curBook.id);
      if (where != null) {
        curBook.isFavorite = 1;
      }
    }
  }*/

  return parsed_gbookList;
}