import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static final String _key = "_key";

  static save(String? usuario) async {
    //Salva o usuário e se está autenticado
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode({"usuario": usuario, "isAuth": true}));
  }

  static Future<bool> isAuth() async {
    //Retorna se está autenticado
    var prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);
      print(mapUser);
      return mapUser['isAuth'];
    }

    return false;
  }
}
