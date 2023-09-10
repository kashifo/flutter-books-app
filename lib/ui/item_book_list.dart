import 'package:books_app/commons.dart';
import 'package:books_app/book_detail.dart';
import 'package:books_app/models/GBook.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class BooksList extends StatelessWidget {
  const BooksList({super.key, required this.gBookList});

  final GBookList gBookList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gBookList.items?.length,
      itemBuilder: (context, index) {
        return ItemBookList(gBook: gBookList.items![index]);
      },
    );
  }
}

class ItemBookList extends StatelessWidget {
  const ItemBookList({super.key, required this.gBook});

  final GBook gBook;

  @override
  Widget build(BuildContext context) {

    print("thumb:${gBook.volumeInfo!.getThumbnail()}");

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
              ExtendedImage.network(
                gBook.volumeInfo!.getThumbnail(),
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
                      getAuthors(gBook.volumeInfo!.authors),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Jost'),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      handleNull(gBook.volumeInfo?.publisher),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
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