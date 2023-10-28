import 'package:flutter/material.dart';

Widget noNetworkWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/no_wifi.png',
          width: 60,
        ),
        const SizedBox(
          height: 16,
        ),
        const Text('Unable to access Internet'),
      ],
    ),
  );
}
