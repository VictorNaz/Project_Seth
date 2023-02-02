import 'dart:convert';
import 'package:flutter_project_seth/backEnd/modelo/faixa.dart';
import 'package:http/http.dart' as http;

import '../modelo/aluno.dart';
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

  static Future<String> buscaFaixaId(Faixa progresso) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaFaixaId'));
    request.body =
        await json.encode({"faixa": progresso.faixa, "grau": progresso.grau});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String id = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("Conexão estabelecida! Id da faixa retornado: $id ");
    } else {
      print(response.reasonPhrase);
    }

    return id;
  }

  static Future<void> forcaProgresso(Aluno aluno, Faixa progresso) async {
    try {
      var request = http.Request(
          'POST', Uri.parse('https://apiseth.cyclic.app/forcaProgresso'));
      request.body = json.encode({
        "aluno_id": aluno.id,
        "faixa_id": progresso.id,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print("Progresso alterado com sucesso!");
      } else {
        print(response.reasonPhrase);
        print("Erro ao alterar o progresso!");
      }
    } catch (e) {
      Exception('Erro $e');
    }
  }
}
