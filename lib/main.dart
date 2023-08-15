import 'package:books_app/MyBooks.dart';
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
      home: const MyBooks(),

      title: 'Flutter Something',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.brown, backgroundColor: Colors.white),
        useMaterial3: true,
      ),

    );
  }

}
