import 'package:books_app/commons.dart';
import 'package:books_app/book_detail.dart';
import 'package:books_app/models/GBook.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class BooksGrid extends StatelessWidget {
  const BooksGrid({super.key, required this.gBookList});

  final GBookList gBookList;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: gBookList.items?.length,
        itemBuilder: (context, index) {
          return ItemBooksGrid(gBook: gBookList.items![index]);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 225,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      );
    });
  }
}

class ItemBooksGrid extends StatelessWidget {
  const ItemBooksGrid({super.key, required this.gBook});

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
      
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ExtendedImage.network(
                gBook.volumeInfo!.imageLinks!.getSmallThumbnail(),
                height: 150,
                fit: BoxFit.cover,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0),
              child: Text(
                gBook.volumeInfo!.title!,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jost'),
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 2.0, right: 4.0),
              child: Text(
                getAuthors(gBook.volumeInfo!.authors),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Jost'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
