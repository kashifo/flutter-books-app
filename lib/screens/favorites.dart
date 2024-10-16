import 'package:books_app/models/GBook.dart';
import 'package:books_app/models/GBookList.dart';
import 'package:books_app/widgets/item_book_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late final Box dataBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('favorites');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ValueListenableBuilder(
        valueListenable: dataBox.listenable(),
        builder: (context, data, child) {
          if (data.isEmpty) {
            return const Center(
              child: Text("You haven't liked any books yet"),
            );
          } else {
            print("saved books size: ${dataBox.length}");

            return ListView.builder(
              itemCount: dataBox.length,
              itemBuilder: (context, index) {
                var key = data.keyAt(index);

                GBook curBook = data.get(key);
                //curBook.isFavorite = 1;
                print("itemBook: $curBook");

                return ItemBookList(gBook: curBook);
              },
            );
          }
        },
      ),
    );
  }
}
