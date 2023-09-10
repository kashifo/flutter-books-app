import 'package:flutter/material.dart';

String getSearchUrl(String query){
  return 'https://www.googleapis.com/books/v1/volumes?q=$query&startIndex=0&maxResults=20&key=AIzaSyB54032jqT1-O2USaaEuZlwiSGpmjaWCPg';
}

String getBookDetailUrl(String bookId){
  return 'https://www.googleapis.com/books/v1/volumes/$bookId?key=AIzaSyB54032jqT1-O2USaaEuZlwiSGpmjaWCPg';
}

String handleNull(String? str){
  if(str==null)
    return '';
  else
    return str;
}

String getAuthors(List<String>? list){
  if(list==null || list.isEmpty) {
    return 'Author N/A';
  } else {
    String authors = list.toString();
    var replace1 = authors.replaceAll('[', '');
    var replace2 = replace1.replaceAll(']', '');
    return 'by $replace2';
  }
}

getIntColor(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}

MaterialColor getMaterialColor(String colorCode) {
  int colorValue = int.parse("0xff$colorCode");
  Color color = Color(colorValue);
  Map<int, Color> shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900]
      .asMap()
      .map((key, value) => MapEntry(value, color.withOpacity(1 - (1 - (key + 1) / 10))));

  return MaterialColor(colorValue, shades);
}