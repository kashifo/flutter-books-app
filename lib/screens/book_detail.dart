import 'dart:convert';
import 'package:books_app/utils/MyWebView.dart';
import 'package:books_app/utils/commons.dart';
import 'package:books_app/utils/firestore_commons.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;
import '../models/GBook.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({super.key, required this.bookId});

  final String bookId;

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late GBook gBook;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    checkFavStatusInFB();
  }

  checkFavStatusInFB() async {
    isLiked = await checkFavInFB( widget.bookId );
    print('checkFavStatusInFB()-$isLiked');
    setState(() {
      isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        elevation: 2.0,
      ),
      body: FutureBuilder<GBook>( 
        future: fetchBookDetail(widget.bookId, http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error has occurred! \n\n ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            gBook = snapshot.data!;

            /*var where = dataBox.values.where((GBook) => GBook.id == widget.bookId);
            print('isFav=$where');
            if(where!=null || where.isEmpty){
              setState(() {
                isLiked = true;
              });
            }*/

            return BookDetailUI(gBook: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      persistentFooterButtons: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Read',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print('read pressed - ${gBook.volumeInfo?.previewLink}');

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyWebView(
                                  inUrl: gBook.volumeInfo?.previewLink,
                                )));

                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HiveBoxesView(
                          hiveBoxes: allBoxes,
                          onError: (String errorMessage) =>
                          {
                            print(errorMessage)
                          })),
                    );*/
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              ElevatedButton(
                child: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  print('fav pressed: ${gBook.toString()}');

                  if (isLiked) {
                    updateInFB(gBook, true);
                  } else {
                    gBook.isFavorite = 1;
                    updateInFB(gBook, false);
                  }

                  setState(() {
                    isLiked = !isLiked;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(isLiked
                        ? 'Added to your favorites'
                        : 'Removed from your favorites'),
                    duration: const Duration(seconds: 1),
                  ));
                },
              )
            ],
          ),
        )
      ],
    );
  }
}

Future<GBook> fetchBookDetail(String bookId, http.Client client) async {
  print('---fetchBookDetail()---$bookId');

  var uri = Uri.parse(getBookDetailUrl(bookId));
  print('fetchBookDetail uri=${uri.toString()}');

  final response = await client.get(uri);
  // print('fetchBookDetail response=${response.body}');

  if(response.body.contains('error')){
    if(response.body.contains('"code": 429')){
      return Future.error('API Free Quota Exceeded');
    } else {
      return Future.error('Something went wrong');
    }
  } else {
    // Use the compute function to run parseBookDetail in a separate isolate.
    return compute(parseBookDetail, response.body);
  }

}

// A function that converts a response body into a List<GBook>.
GBook parseBookDetail(String responseBody) {
  print('---parseBookDetail()---');

  final parsedJson = jsonDecode(responseBody);
  // print('parsed_json=$parsedJson');

  final parsedGbook = GBook.fromJson(parsedJson);
  print('---parseBookDetail()---completed');
  // print('parsed_gbook=$parsedGbook');

  return parsedGbook;
}

class BookDetailUI extends StatelessWidget {
  const BookDetailUI({super.key, required this.gBook});

  final GBook gBook;

  @override
  Widget build(BuildContext context) {
    print("thumbnail:${gBook.volumeInfo?.getThumbnail()}");

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
                      gBook.volumeInfo!.getThumbnail(),
                      width: 100,
                      height: 150,
                    ),
                    onTap: () {
                      showGeneralDialog(
                          context: context,
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder: (bc, ania, anis) {
                            return Column(
                              children: [
                                Container(alignment: Alignment.topRight, padding: EdgeInsets.all(8), child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close, color: Colors.white,))),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image(
                                      image: NetworkImage(
                                        gBook.volumeInfo!
                                            .getThumbnail(small: false),
                                      ),
                                      fit: BoxFit.contain,
                                      width: MediaQuery.of(context).size.width-150,
                                      height: MediaQuery.of(context).size.height-150,
                                    ),
                                  ),
                                ),
                              ],
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
                          gBook.volumeInfo!.getAuthors(),
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
