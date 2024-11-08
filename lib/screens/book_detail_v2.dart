import 'package:books_app/models/GBook.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/ResponsiveUtils.dart';
import '../utils/commons.dart';

class BookDetailV2 extends StatefulWidget {
  const BookDetailV2({super.key, required this.bookId});

  final String bookId;

  @override
  State<BookDetailV2> createState() => _BookDetailV2State();
}

class _BookDetailV2State extends State<BookDetailV2> {
  late GBook gBook;
  late Box dataBox;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    /*dataBox = Hive.box('favorites');

    var where = dataBox.get(widget.bookId);
    print('isFav=$where');
    if(where!=null){
      isLiked = true;
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              // expandedHeight: ResponsiveUtils.getScrWidth(context),
              expandedHeight: 300,
              floating: false,
              pinned: true,
              leading: const Icon(Icons.arrow_back_rounded),
              iconTheme: const IconThemeData(color: Colors.black),
              actions: [
                PopupMenuButton(
                    // add icon, by default "3 dot" icon
                    // icon: Icon(Icons.book)
                    itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("My Account"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Settings"),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text("Logout"),
                    ),
                  ];
                }, onSelected: (value) {
                  if (value == 0) {
                    print("My account menu is selected.");
                  } else if (value == 1) {
                    print("Settings menu is selected.");
                  } else if (value == 2) {
                    print("Logout menu is selected.");
                  }
                }),
              ],
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                      color: getIntColor("FCF4C5"),
                      child: Center(
                          child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10.0,
                              spreadRadius: 2,
                              offset: Offset(
                                2,
                                2,
                              ), //New
                            )
                          ],
                        ),
                        child: Image.network(
                          // "https://books.google.com/books/content?id=FzVjBgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
                          "https://books.google.com/books/content?id=z_RoMAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
                          fit: BoxFit.fitHeight,
                          height: 200,
                        ),
                      )))),
            ),
          ];
        },
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              // getAuthors(gBook.volumeInfo!.authors),
              "Paulo Coelho's",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Jost'),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'The Alchemist',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost'),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              // handleNull(gBook.volumeInfo?.publisher),
              'by Simon & Schuster',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Jost'),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                greyBox('4.1', 'Rating'),
                greyBox('5.4m', 'Read'),
                greyBox('59k', 'Reviews'),
                greyBox('14k', 'Quotes'),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Add to Favorites',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 4,
              margin: EdgeInsets.only(top: 16, bottom: 16),
              color: Colors.grey.shade300,
            ),

            Container(
              padding: const EdgeInsets.only(left: 16),
              height: 35,
              child: ListView(
                scrollDirection: Axis.horizontal,
                      children: [
                        roundText('Classics'),
                        roundText('Fiction'),
                        roundText('Historical'),
                        roundText('Sci-Fi'),
                        roundText('Sci-Fi'),
                      ]
                  ),
            ),

            SizedBox(
              height: 8,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "This is the description of the book named Alchemist, It's main story is 'If you really wish for something the whole world works for you",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Jost'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



Widget roundText(String str){
  return Container(
    margin: EdgeInsets.only(right: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20))

    ),
    child: Text(
      str,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12
      ),
    ),
  );
}

Widget greyBox(String line1, String line2){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade300,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8),

    ),
    child: Column(
      children: [
        Text(
          line1,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12
          ),
        ),
        Text(
          line2,
          style: TextStyle(
              fontSize: 10
          ),
        )
      ],
    ),
  );
}
