import 'package:flutter/material.dart';

import '../utils/commons.dart';

class BookDetailV2 extends StatefulWidget {
  const BookDetailV2({super.key});

  @override
  State<BookDetailV2> createState() => _BookDetailV2State();
}

class _BookDetailV2State extends State<BookDetailV2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: ResponsiveUtils.getScrWidth(context),
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
                      padding: const EdgeInsets.all(1),
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
                        ),
                      )))),
            ),
          ];
        },
        body: Center(
          child: Text('New dish detail screen is coming'),
        ),
      ),
    );
  }
}
