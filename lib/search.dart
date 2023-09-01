import 'dart:convert';

import 'package:books_app/commons.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ui/item_book_list.dart';

String query = '';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<StatefulWidget> createState() {
    return SearchState();
  }
}

class SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: const Color(0xff1D1617).withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 0.0)
            ]
            ),
            child: TextField(
              autofocus: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onSubmitted: (searchVal) {
                setState(() {
                  query = searchVal;
                });
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Type something to search',
                  hintStyle:
                  const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.search, color: Colors.black54,),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none)),
            ),
          ),

          Expanded(
            child: FutureBuilder<GBookList>(
              future: searchBooks(http.Client()),
              builder: (context, snapshot) {
                if (query.isEmpty) {
                  return const Center(
                    child: Text(''),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('An error has occurred! \n\n ${snapshot.error}'),
                  );
                } else if (snapshot.hasData &&
                    snapshot.data?.items != null &&
                    snapshot.data!.items!.isNotEmpty) {
                  return BooksList(gBookList: snapshot.data!);
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
    );
  }
}

Future<GBookList> searchBooks(http.Client client) async {
  print('---searchBooks()---$query');
  if (!query.isEmpty) {
    final response = await client.get(Uri.parse(getSearchUrl(query)));

    //print('searchBooks response=${response.body}');

    // Use the compute function to run parser in a separate isolate.
    return compute(parseBooks, response.body);
  } else {
    return GBookList();
  }
}

// A function that converts a response body into a List<GBookList>.
GBookList parseBooks(String responseBody) {
  print('---parseBooks()---');

  final parsed_json = jsonDecode(responseBody);
  //print('parsed_json=$parsed_json');

  final parsed_gbookList = GBookList.fromJson(parsed_json);
  //print('parsed_gbookList=${parsed_gbookList.toString()}');

  return parsed_gbookList;
}
