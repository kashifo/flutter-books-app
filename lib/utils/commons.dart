import 'package:flutter/material.dart';
// import 'secrets.dart';

String getSearchUrl(String query){

  //TODO: Comment this if clause if it is not commented, if you've cloned this repo as public or facing error. Or add your own api key for accessing Google Books in the below variable
  //var API_KEY_GOOGLE_SECRET = '';
  /*if(API_KEY_GOOGLE_SECRET!=null){
    return 'https://www.googleapis.com/books/v1/volumes?q=$query&startIndex=0&maxResults=20&key=$API_KEY_GOOGLE_SECRET';
  }*/

  return 'https://www.googleapis.com/books/v1/volumes?q=$query&startIndex=0&maxResults=20';
}

String getBookDetailUrl(String bookId){
  //TODO: Comment this if clause if it is not commented, if you've cloned this repo as public or facing error. Or add your own api key for accessing Google Books in the below variable
  //var API_KEY_GOOGLE_SECRET = '';
  /*if(API_KEY_GOOGLE_SECRET!=null){
    return 'https://www.googleapis.com/books/v1/volumes/$bookId?key=$API_KEY_GOOGLE_SECRET';
  }*/

  return 'https://www.googleapis.com/books/v1/volumes/$bookId';
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