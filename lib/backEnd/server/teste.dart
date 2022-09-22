import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Teste {
  ///NomeSala = nome que a sala vai receber
  ///TipoToken = publisher ou audience , sendo publisher quem faz a sala e audience quem escuta
  static Future<String> test() async {
    print("teste");
    final response = await http.get(Uri.parse('http://10.3.77.254:3000/teste'));

    return jsonDecode(response.body);
  }
}
