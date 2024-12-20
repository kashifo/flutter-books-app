import 'dart:convert';
import 'package:firedart/firedart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesStore extends TokenStore {
  static const keyToken = "auth_token";

  static Future<PreferencesStore> create() async =>
      PreferencesStore._internal(await SharedPreferences.getInstance());

  SharedPreferences _prefs;

  PreferencesStore._internal(this._prefs);

/*  @override
  Token? read() => _prefs.containsKey(keyToken)
      ? Token.fromMap(json.decode(_prefs.get(keyToken)))
      : null;

  @override
  void write(Token token) =>
      _prefs.setString(keyToken, json.encode(token.toMap()));*/

  @override
  void delete() => _prefs.remove(keyToken);

  @override Token? read() => _prefs.containsKey(keyToken)  ? Token.fromMap(json.decode(_prefs.get(keyToken) as String))  : null;

  @override void write(Token? token) => token != null  ? _prefs.setString(keyToken, json.encode(token.toMap()))  : null;

}
