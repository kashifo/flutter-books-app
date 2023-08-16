import 'package:books_app/book_detail.dart';
import 'package:books_app/book_list_dynamic.dart';
import 'package:books_app/book_list_static.dart';
import 'package:books_app/api_test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BookList(),

      title: 'Flutter BooksApp',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.brown, backgroundColor: Colors.white),
        useMaterial3: true,
      ),

    );
  }

}
