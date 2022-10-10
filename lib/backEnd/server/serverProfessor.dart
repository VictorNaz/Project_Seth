import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modelo/professor.dart';

//Escopo padrão com Auth nos paramêtros
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Basic YWRtaW46QWxlc2V0aCFAIw=='
};

class ServerProfessor {
  static Future<void> cadastrarProfessor(Professor professor) async {
    try {
      print(professor.usuario);
      var request = http.Request(
          'POST', Uri.parse('https://apiseth.cyclic.app/cadastrarProfessor'));
      request.body = json.encode({
        "usuario": professor.usuario,
        "senha": professor.senha,
        "nome": professor.nome,
        "email": professor.email,
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
