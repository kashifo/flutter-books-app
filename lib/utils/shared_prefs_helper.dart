import 'package:books_app/utils/Enumz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper{

  static late SharedPreferences sprefs;

  static init() async{
    sprefs = await SharedPreferences.getInstance();
  }

  static bool isLoggedIn(){
    return sprefs.getBool(Enumz.isLoggedIn.name) ?? false;
  }

  static String? getString(String key){
    return sprefs.getString(key);
  }

  static setString(String key, String value){
    sprefs.setString(key, value);
  }

  static int? getInt(String key){
    return sprefs.getInt(key);
  }

  static setInt(String key, int value){
    sprefs.setInt(key, value);
  }

  static bool? getBool(String key){
    return sprefs.getBool(key);
  }

  static setBool(String key, bool value){
    sprefs.setBool(key, value);
  }

  clear(){
    sprefs.clear();
  }

}