import 'dart:async';
import 'dart:convert';
import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';
import 'package:http/http.dart' as http;

class ServerAluno {
  static Future<void> cadastrarAluno(Aluno aluno) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/cadastrarAluno'));
    request.body = json.encode({
      "nome": aluno.nome,
      "usuario": aluno.usuario,
      "senha": aluno.senha,
      "cpf": aluno.cpf,
      "faixa_id": 1,
      "email": aluno.email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

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
          'Conexão não estabelecida! Não foi possivel se conectar ao endereço $url_Api.\n Erro $e');
    }
  }

  static Future<int> buscaAlunoId(Aluno aluno)  async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('https://apiseth.cyclic.app/buscaAlunoId'));
    request.body = json.encode({"user": aluno.usuario});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String id = await response.stream.bytesToString();
    int idAluno = int.parse(id);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return idAluno;
  }

  static Future<void> iniciaProgresso(int? id) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET', Uri.parse('https://apiseth.cyclic.app/iniciaProgresso'));
    request.body = json.encode({"id": "$id"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
