import 'dart:convert';

import 'package:books_app/commons.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:http/http.dart' as http;
import 'models/GBook.dart';

class BookDetail extends StatelessWidget {
  const BookDetail({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        elevation: 2.0,
      ),
      body: FutureBuilder<GBook>(
        future: fetchBookDetail(bookId, http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error has occurred! \n\n ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return BookDetailUI(gBook: snapshot.data!);
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

Future<GBook> fetchBookDetail(String bookId, http.Client client) async {
  print('---fetchBookDetail()---$bookId');

  final response = await client
      .get(Uri.parse('https://www.googleapis.com/books/v1/volumes/$bookId'));

  //print('fetchBookDetail response=${response.body}');

  // Use the compute function to run parseBookDetail in a separate isolate.
  return compute(parseBookDetail, response.body);
}

// A function that converts a response body into a List<GBook>.
GBook parseBookDetail(String responseBody) {
  //print('---parseBookDetail()---');

  final parsedJson = jsonDecode(responseBody);
  //print('parsed_json=$parsedJson');

  final parsedGbook = GBook.fromJson(parsedJson);
  //print('parsed_gbook=$parsedGbook');

  return parsedGbook;
}

class BookDetailUI extends StatelessWidget {
  const BookDetailUI({super.key, required this.gBook});

  final GBook gBook;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              height: 150,
              child: Row(
                children: [
                  InkWell(
                    child: ExtendedImage.network(
                      gBook.volumeInfo!.imageLinks!.getSmallThumbnail(),
                      width: 100,
                      height: 150,
                    ),

                    onTap: () {
                      showGeneralDialog(
                          context: context,
                          transitionDuration: Duration(milliseconds: 400),
                          pageBuilder: (bc, ania, anis) {
                            return SizedBox.expand(
                              child: Center(
                                child: Image(
                                  image: NetworkImage(
                                      gBook.volumeInfo!.imageLinks!.thumbnail!
                                  ),
                                  fit: BoxFit.fitWidth,
                                  width: 300,
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  const SizedBox(
                    width: 8,
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
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Jost'),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          getAuthors(gBook.volumeInfo!.authors),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Jost'),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          handleNull(gBook.volumeInfo?.publisher),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Jost'),
                        ),
                        Text(
                          '${gBook.volumeInfo!.pageCount!} Pages',
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
            const SizedBox(
              height: 16,
            ),
            HtmlWidget(
              handleNull(gBook.volumeInfo?.description),
              textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Jost'),
            )
          ],
        ),
      ),
    );
  }
}
