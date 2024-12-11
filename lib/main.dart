import 'package:books_app/screens/login.dart';
import 'package:books_app/screens/search.dart';
import 'package:books_app/utils/ResponsiveUtils.dart';
import 'package:books_app/utils/commons.dart';
import 'package:books_app/screens/discover.dart';
import 'package:books_app/screens/favorites.dart';
import 'package:books_app/utils/shared_prefs_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/PreferencesStore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper().init();
  await initFireDart();

  runApp(const MyApp());
}

initFireDart() async {
  FirebaseAuth.initialize(const String.fromEnvironment('FIREBASE_KEY'), await PreferencesStore.create());
  Firestore.initialize(const String.fromEnvironment('FIREBASE_PROJECT_ID'));
  var auth = FirebaseAuth.instance;

  if(auth.isSignedIn){
    // Get user object
    var user = await auth.getUser();
    print('user=$user');
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.calcScrWidth(context);

    return GetMaterialApp(
      home: FirebaseAuth.instance.isSignedIn ? TabView() : LoginScreen(),
      title: 'Flutter BooksApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Jost',
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: getMaterialColor('0065ff'),
            backgroundColor: Colors.white),
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white.withOpacity(0.8),
        cardColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.2)
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: getMaterialColor('0065ff'),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black87,
          cardColor: Colors.black,
          shadowColor: Colors.white24
      ),
      themeMode: ThemeMode.light,
    );
  }
}

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  // var subscription;

  @override
  void initState() {
    super.initState();

/*    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('network changed');
      checkNetwork();
    });*/
  }//initState

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
    // subscription.cancel();
    super.dispose();
  }

  final List<Widget> tabScreenList = [
    const Discover(),
    const Search(),
    const Favorites()
  ];
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabScreenList[tabIndex],
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
