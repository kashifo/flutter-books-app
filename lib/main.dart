import 'package:books_app/utils/commons.dart';
import 'package:books_app/discover.dart';
import 'package:books_app/favorites.dart';
import 'package:books_app/models/GBook.dart';
import 'package:books_app/search.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(ImageLinksAdapter());
  Hive.registerAdapter(VolumeInfoAdapter());
  Hive.registerAdapter(GBookAdapter());

  await Hive.openBox('favorites');

  runApp(
      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TabView(),
      title: 'Flutter BooksApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Jost',
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: getMaterialColor('0065ff'), backgroundColor: Colors.white),
        useMaterial3: true,
      ),

    );
  }

}

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final List<Widget> children = [
    const Discover(),
    const Search(),
    const Favorites()
  ];
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[tabIndex],

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.saved_search_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: '',
          ),
        ],
        currentIndex: tabIndex,
        selectedItemColor: getIntColor("0065ff"),

        onTap: (int index){
          setState(() {
            print('onTapped=$index');
            tabIndex = index;
          });
        },
      ),
    );
  }
}

