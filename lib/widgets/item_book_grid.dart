import 'package:books_app/utils/commons.dart';
import 'package:books_app/models/GBook.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../screens/book_detail.dart';
import '../utils/ResponsiveUtils.dart';

class BooksGrid extends StatefulWidget {
  const BooksGrid({super.key, required this.gBookList});

  final GBookList gBookList;

  @override
  State<BooksGrid> createState() => _BooksGridState();
}

class _BooksGridState extends State<BooksGrid> {
  late Box dataBox;
  // bool isDesktop = false;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('favorites');

    /*if (ResponsiveUtils.isDesktop(context)) {
      isDesktop = true;
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: widget.gBookList.items?.length,
        itemBuilder: (context, index) {
          GBook curBook = widget.gBookList.items![index];

          var where = dataBox.get(curBook.id);
          if (where != null) {
            curBook.isFavorite = 1;
          }

          return ItemBooksGrid(gBook: curBook);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          // mainAxisExtent: isDesktop ? 425 : 225,
          mainAxisExtent: 280,
          mainAxisSpacing: 0,
          crossAxisSpacing: 8.0,
        ),
      );
    });
  }
}

class ItemBooksGrid extends StatefulWidget {
  const ItemBooksGrid({super.key, required this.gBook});

  final GBook gBook;

  @override
  State<ItemBooksGrid> createState() => _ItemBooksGridState();
}

class _ItemBooksGridState extends State<ItemBooksGrid> {
  bool isLiked = false;
  // bool isDesktop = false;

  @override
  void initState() {
    super.initState();

    if (widget.gBook.isFavorite == 1) {
      isLiked = true;
    } else {
      isLiked = false;
    }

    /*if (ResponsiveUtils.isDesktop(context)) {
      isDesktop = true;
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetail(
                      bookId: widget.gBook.id!,
                    )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Stack(children: [
              ExtendedImage.network(
                widget.gBook.volumeInfo!.getThumbnail(small: false),
                height: 200,
                // height: isDesktop ? 350 : 150,
                //todo: make platform specific, mac/desktop=350, mobile=150
                width: double.infinity,
                fit: BoxFit.cover,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                        // size: isDesktop? 32 : 16,
                        size: 25,
                        shadows: const <Shadow>[
                          Shadow(color: Colors.blue, blurRadius: 1.0)
                        ],
                        color: Colors.blue,
                        isLiked ? Icons.favorite : Icons.favorite_border),
                  ),
                  onTap: () {
                    Box dataBox = Hive.box('favorites');

                    print('fav pressed: ${widget.gBook.isFavorite}');

                    if (widget.gBook.isFavorite == 1) {
                      dataBox.delete(widget.gBook.id);
                    } else {
                      widget.gBook.isFavorite = 1;
                      dataBox.put(widget.gBook.id, widget.gBook);
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
                  }),
            ]),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0),
            child: Text(
              widget.gBook.volumeInfo!.title!,
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
              getAuthors(widget.gBook.volumeInfo!.authors),
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
    );
  }
}
