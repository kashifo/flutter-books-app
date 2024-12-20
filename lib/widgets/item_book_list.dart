import 'package:books_app/utils/commons.dart';
import 'package:books_app/models/GBook.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:books_app/utils/firestore_commons.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/book_detail.dart';

class BooksList extends StatefulWidget {
  const BooksList({super.key, required this.gBookList});

  final GBookList gBookList;

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.gBookList.items?.length,
      itemBuilder: (context, index) {
        GBook curBook = widget.gBookList.items![index];
        return ItemBookList(gBook: curBook);
      },
    );
  }
}

class ItemBookList extends StatefulWidget {
  const ItemBookList({super.key, required this.gBook});

  final GBook gBook;

  @override
  State<ItemBookList> createState() => _ItemBookListState();
}

class _ItemBookListState extends State<ItemBookList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("thumb:${widget.gBook.volumeInfo!.getThumbnail()}");

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetail(
                      bookId: widget.gBook.id!,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),

        decoration: BoxDecoration(
          // color: Colors.white,
          color: Get.isDarkMode ? Colors.black : Colors.white,
          // color: Theme.of(context).cardColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 2,
                spreadRadius: 1,
                color: Colors.grey.withOpacity(0.1)
                // color: Theme.of(context).shadowColor
            )
          ]
        ),

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ExtendedImage.network(
                widget.gBook.volumeInfo!.getThumbnail(),
                width: 100,
                height: 100,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.gBook.volumeInfo!.title!,
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
                    widget.gBook.volumeInfo!.getAuthors(),
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
                    handleNull(widget.gBook.volumeInfo?.publisher),
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
            ),
            IconButton(
              icon: Icon(
                  color: Colors.blue,
                  widget.gBook.isFavorite==1 ? Icons.favorite : Icons.favorite_border),
              onPressed: () {

                print('fav pressed: ${widget.gBook.isFavorite}');

                  if (widget.gBook.isFavorite == 1) {
                    updateInFB(widget.gBook, true);
                  } else {
                    updateInFB(widget.gBook, false);
                  }

                  setState(() {
                    if (widget.gBook.isFavorite == 1) {
                      widget.gBook.isFavorite = 0;
                    } else {
                      widget.gBook.isFavorite = 1;
                    }
                  });


                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(widget.gBook.isFavorite==1
                      ? 'Added to your favorites'
                      : 'Removed from your favorites'),
                  duration: const Duration(seconds: 1),
                ));
              }, //onPressed
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
