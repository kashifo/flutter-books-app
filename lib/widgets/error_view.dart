import 'package:flutter/material.dart';

Widget errorViewWidget(String title, String message, String? errorDetail) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/alert.png',
            width: 60,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(
            height: 24,
          ),
          Text(errorDetail??'',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
        ],
      ),
    ),
  );
}
