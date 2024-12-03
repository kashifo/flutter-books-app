import 'package:books_app/models/GBook.dart';
import 'package:books_app/screens/login.dart';
import 'package:books_app/utils/shared_prefs_helper.dart';
import 'package:books_app/widgets/item_book_list.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  // late final Box dataBox;
  List<GBook> gbookList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // dataBox = Hive.box('favorites');
    fetchFavorites();
  }

  fetchFavorites() async {
    isLoading = true;

    var snapshot = await Firestore.instance
        .collection('users')
        .document( FirebaseAuth.instance.userId )
        .collection('favorites')
        .get();

    print('toList=${snapshot.toList().length}');
    var list = snapshot.toList();

    for (var favorite in list) {
      VolumeInfo  vi = VolumeInfo.lite(
        title: favorite['bookName'],
        authorStr: favorite['authors'],
        publisher: favorite['publisher'],
        imageLinks: ImageLinks(
            smallThumbnail: favorite['imageUrl'],
            thumbnail: favorite['imageUrl']
        ),
      );
      GBook gBook = GBook(id: favorite.id, volumeInfo: vi, isFavorite: 1);
      gbookList.add(gBook);
    }

    setState(() {
      isLoading = false;
      gbookList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w600),
        ),
        /*backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,*/
        actions: [
          InkWell(
            onTap: (){
              print('isDark=${Get.isDarkMode}');
              Get.changeTheme(Get.isDarkMode? ThemeData.light(): ThemeData.dark());
              // Get.changeThemeMode(Get.isDarkMode? ThemeMode.light: ThemeMode.dark);
            },
              child: Icon(Icons.light_mode)
          ),
          SizedBox(width: 16),
          InkWell(
            onTap: () {
              SharedPrefsHelper().clear();
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(Icons.logout),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: showFavoritesfromFB(),
    );
  }

  Widget showFavoritesfromFB(){
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (gbookList.isEmpty) {
      return const Center(
        child: Text("You haven't liked any books yet"),
      );
    } else {
      print("saved books size: ${gbookList.length}");

      return ListView.builder(
        itemCount: gbookList.length,
        itemBuilder: (context, index) {
          GBook curBook = gbookList[index];
          return ItemBookList(gBook: curBook);
        },
      );
    }
  }

  /*Widget showFavoritesFromHive(){
    return ValueListenableBuilder(
      // valueListenable: dataBox.listenable(),
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
    );
  }*/

}
