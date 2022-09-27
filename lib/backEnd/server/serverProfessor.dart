import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modelo/professor.dart';

class ServerProfessor {
  static Future<void> cadastrarProfessor(Professor professor) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      print(professor.usuario);
      var request = http.Request(
          'POST', Uri.parse('https://apiseth.cyclic.app/cadastrarProfessor'));
      request.body = json.encode({
        "usuario": professor.usuario,
        "senha": professor.senha,
        "nome": professor.nome,
        "email": professor.email,
        "telefone": professor.telefone,
        "cpf": professor.cpf,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      Exception('Erro $e');
    }
  }
}
