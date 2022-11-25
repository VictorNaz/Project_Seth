import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static final String _key = "_key";

  static save(String? usuario) async {
    //Salva o usuário e se está autenticado
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode({"usuario": usuario, "isAuth": true}));
    print(usuario);
  }

  static Future<bool> isAuth() async {
    //Retorna se está autenticado
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);
      print(mapUser);
      print(jsonResult);
      return mapUser['isAuth'];
    }

    return false;
  }

  //Remove a chavee do Shared, desativando a sessão
  static logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static Future<String?> returnUser() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);
      return mapUser['usuario']; //Retorna o valor de 'usuario' do Json
    }
    return "Não encontrado";
  }
}
