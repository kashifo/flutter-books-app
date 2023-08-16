import 'dart:convert';

import 'package:books_app/book_detail.dart';
import 'package:books_app/models/GBook.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<StatefulWidget> createState() {
    return BookListState();
  }
}

class BookListState extends State<BookList> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Books',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
      ),
      // body: getWidget(isGrid));
      body: FutureBuilder<GBookList>(
        future: fetchBooks(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error has occurred! \n\n ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
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





Future<GBookList> fetchBooks(http.Client client) async {
  print('---fetchBooks()---');

  final response = await client
      .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=business&startIndex=0&maxResults=20'));

  print( 'fetchBooks response=${response.body}' );

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseBooks, response.body);
}

// A function that converts a response body into a List<GBookList>.
GBookList parseBooks(String responseBody) {
  print('---parseBooks()---');

  final parsed_json = jsonDecode(responseBody);
  print('parsed_json=$parsed_json');

  final parsed_gbookList = GBookList.fromJson(parsed_json);
  print('parsed_gbookList=${parsed_gbookList.toString()}');

  return parsed_gbookList;
}

class BooksGrid extends StatelessWidget {
  const BooksGrid({super.key, required this.gBookList});

  final GBookList gBookList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gBookList.items?.length,
      itemBuilder: (context, index) {
        return ItemBook(gBook: gBookList.items![index]);
      },
    );
  }
}


class ItemBook extends StatelessWidget {
  const ItemBook({super.key, required this.gBook});
  final GBook gBook;

  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDetail(
                        bookId: gBook.id!,
                      )));
        },
        child: Container(
          height: 100,
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image(
                  image: gBook.volumeInfo!.imageLinks!.getSmallThumbnail().isNotEmpty
                      ? NetworkImage(gBook.volumeInfo!.imageLinks!.getSmallThumbnail())
                      : const NetworkImage('http://books.google.com/books/content?id=wjB-wwEACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE72kghnIhXnM9okGcBmBypLoiEUicp-kXJ6YjBe_LnbaFeSrrgTx9AvpwXW5ZdcgoUgUqgb_T8KpXQQCHupkL7s6eRcFdSYi1dnswp6IhWwXKidFDN4jzOKfSO-xhpZvus1ZtuMh&source=gbs_api'),
                  width: 100,
                  height: 100,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        gBook.volumeInfo!.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost'),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        gBook.volumeInfo!.authors.toString()!,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Jost'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

