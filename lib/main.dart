import 'package:books_app/screens/book_detail_v2.dart';
import 'package:books_app/screens/search.dart';
import 'package:books_app/utils/commons.dart';
import 'package:books_app/screens/discover.dart';
import 'package:books_app/screens/favorites.dart';
import 'package:books_app/models/GBook.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ImageLinksAdapter());
  Hive.registerAdapter(VolumeInfoAdapter());
  Hive.registerAdapter(GBookAdapter());

  await Hive.openBox('favorites');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BookDetailV2(),
      title: 'Flutter BooksApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Jost',
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: getMaterialColor('0065ff'),
            backgroundColor: Colors.white),
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
  var subscription;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('network changed');
      checkNetwork();
    });

  }

  void checkNetwork({bool notifyOnConnectAlso = false}) async {
    print('checkNetwork');

    final connectivityResult = await (Connectivity().checkConnectivity());
    print('checkNetwork connectivityResult=$connectivityResult');

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {

      if(notifyOnConnectAlso) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Internet connected, please refresh if needed.'),
        ));
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No Internet connection'),
      ));
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

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
        onTap: (int index) {
          setState(() {
            print('onTapped=$index');
            tabIndex = index;
          });
        },
      ),
    );
  }
}
