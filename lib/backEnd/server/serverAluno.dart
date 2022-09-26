import 'dart:async';
import 'dart:convert';
import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';
import 'package:http/http.dart' as http;

class ServerAluno {
  static Future<void> validaAluno(Aluno aluno) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      String url_Api = 'https://apiseth.cyclic.app/validarAluno';
      var request = http.Request('POST', Uri.parse(url_Api));
      request.body = json.encode({
        "usuario": aluno.usuario,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, url_Api) {
      throw Exception(
          'Conexão não estabelecida! Não foi possivel se conectar ao endereço $url_Api.  $e');
    }
  }
}
