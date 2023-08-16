import 'dart:convert';

import 'package:books_app/models/GBookList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'models/GBook.dart';


class ApiTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Test'),
      ),
      body: FutureBuilder<GBookList>(
        future: fetchJsonObj2(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error has occurred! \n\n ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return Center(
              child: Text('snapshot.data= \n\n ${snapshot.data!}'),
            );
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


Future<GBook> fetchJsonObj(http.Client client) async {
  print('---fetchPhotos()---');

  final response = await client
      .get(Uri.parse('https://www.googleapis.com/books/v1/volumes/wjB-wwEACAAJ'));

  print( 'fetchPhotos response=${response.body}' );

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseJsonObj, response.body);
}

// A function that converts a response body into a List<GBook>.
GBook parseJsonObj(String responseBody) {
  print('---parsePhotos()---');

  final parsed_json = jsonDecode(responseBody);
  print('parsed_json=$parsed_json');

  final parsed_gbook = GBook.fromJson(parsed_json);
  print('parsed_gbook=$parsed_gbook');

  return parsed_gbook;
}







Future<GBookList> fetchJsonObj2(http.Client client) async {
  print('---fetchJsonObj2()---');

  final response = await client
      .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=business&startIndex=0&maxResults=2'));

  print( 'fetchPhotos response=${response.body}' );

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseJsonObj2, response.body);
}

// A function that converts a response body into a List<GBookList>.
GBookList parseJsonObj2(String responseBody) {
  print('---parseJsonObj2()---');

  final parsed_json = jsonDecode(responseBody);
  print('parsed_json=$parsed_json');

  final parsed_gbookList = GBookList.fromJson(parsed_json);
  print('parsed_gbookList=${parsed_gbookList.toString()}');

  return parsed_gbookList;
}







Future<List<GBook>> fetchPhotos(http.Client client) async {
  print('---fetchPhotos()---');

  final response = await client
      .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=business&startIndex=0&maxResults=2'));

  print( 'fetchPhotos response=${response.body}' );

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<GBook>.
List<GBook> parsePhotos(String responseBody) {
  print('---parsePhotos()---');

  final parsed_json = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('parsed_json=parsed_json');

  final gbookList = parsed_json.map<GBook>((json) => GBook.fromJson(json)).toList();
  print('gbookList=$gbookList');

  return gbookList;
}
