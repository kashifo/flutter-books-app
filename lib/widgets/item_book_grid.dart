import 'package:books_app/models/GBook.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:books_app/utils/firestore_commons.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../screens/book_detail.dart';
import '../utils/ResponsiveUtils.dart';

class BooksGrid extends StatefulWidget {
  const BooksGrid({super.key, required this.gBookList});

  final GBookList gBookList;

  @override
  State<BooksGrid> createState() => _BooksGridState();
}

class _BooksGridState extends State<BooksGrid> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: widget.gBookList.items?.length,
        itemBuilder: (context, index) {
          GBook curBook = widget.gBookList.items![index];
          return ItemBooksGrid(gBook: curBook);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisCount: ResponsiveUtils.scrWidth>500 ? 5 : 3,
          crossAxisCount: (ResponsiveUtils.scrWidth/200).round(),
          // mainAxisExtent: ResponsiveUtils.scrWidth>700 ? 425 : 225,
          mainAxisExtent: ResponsiveUtils().incByPercentage( (ResponsiveUtils.scrWidth / (ResponsiveUtils.scrWidth/200).round()), 50),
          //   mainAxisExtent: 350,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
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
      child: Container(
        /*elevation: 2,
        shadowColor: Colors.black,*/
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 4,
                spreadRadius: 1,
                color: Colors.black.withOpacity(0.2))
          ],
          borderRadius: BorderRadius.circular(10),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 8,
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(children: [
                    ExtendedImage.network(
                      widget.gBook.volumeInfo!.getThumbnail(small: false),
                      width: double.infinity,
                      height: double.infinity,
                      // height: ResponsiveUtils.scrWidth>700 ? 200 : 150,
                      //todo: make platform specific, mac/desktop=350, mobile=150
                      fit: BoxFit.cover,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.only( topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0) ),
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
                              widget.gBook.isFavorite==1 ? Icons.favorite : Icons.favorite_border),
                        ),
                        onTap: () {

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
                        }),
                  ]),
                ),
            ),

            Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, top: 4.0, right: 4.0),
                      child: Text(
                        widget.gBook.volumeInfo!.title!,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost'),
                      ),
                    ),
                    const SizedBox(height: 0),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, top: 2.0, right: 4.0),
                      child: Text(
                        widget.gBook.volumeInfo!.getAuthors(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Jost'),
                      ),
                    )
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
}

