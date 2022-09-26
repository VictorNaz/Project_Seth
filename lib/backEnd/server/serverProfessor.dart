import 'dart:async';
import 'dart:convert';
import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';
import 'package:http/http.dart' as http;

import '../modelo/professor.dart';

class cadastroProfessor {
  static Future<void> cadastrarProfessor(Professor professor) async {
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://apiseth.cyclic.app/cadastrarProfessor'));
    request.body = json.encode({
      "user": professor.usuario,
      "password": professor.senha,
      "nome": professor.nome,
      "email": professor.email,
      "telefone": professor.telefone,
      "cpf": professor.cpf,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }
}
