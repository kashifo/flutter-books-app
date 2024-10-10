import 'package:books_app/screens/book_detail_v2.dart';
import 'package:books_app/utils/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const BookDetailV2(bookId: 'lassldf'),

    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Jost',
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown,
          accentColor: Colors.blueAccent,
          backgroundColor: Colors.grey.shade100),
      useMaterial3: true,
    ),
  ));
}
