import 'package:books_app/models/GBookList.dart';
import 'package:books_app/ui/item_book_list.dart';
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
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text("You haven't liked any books yet"),
            );
          } else {
            return ListView.builder(
              itemCount: dataBox.length,
              itemBuilder: (context, index) {
                var box = value;
                var key = box.keyAt(index);
                var getData = box.get(key);
                print("itemBook: $getData");

                return ItemBookList(gBook: getData);
              },
            );
          }
        },
      ),
    );
  }
}
