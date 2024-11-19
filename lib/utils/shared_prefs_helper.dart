import 'package:books_app/utils/Enumz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper{

  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();
  factory SharedPrefsHelper() {
    return _instance;
  }
  SharedPrefsHelper._internal();

  late SharedPreferences sprefs;

  Future<void> init() async{
    sprefs = await SharedPreferences.getInstance();
  }

  bool isLoggedIn(){
    return sprefs.getBool(Enumz.isLoggedIn.name) ?? false;
  }

  String? getString(String key){
    return sprefs.getString(key);
  }

  setString(String key, String value){
    sprefs.setString(key, value);
  }

  int? getInt(String key){
    return sprefs.getInt(key);
  }

  setInt(String key, int value){
    sprefs.setInt(key, value);
  }

  bool? getBool(String key){
    return sprefs.getBool(key);
  }

  setBool(String key, bool value){
    sprefs.setBool(key, value);
  }

  clear(){
    sprefs.clear();
  }

}