import 'dart:async';
import 'dart:convert';
import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';
import 'package:flutter_project_seth/backEnd/security/sessionService.dart';
import 'package:http/http.dart' as http;

//Pendencias
//Validação de campos para dados repetidos
//Criptografia de senha

//Escopo padrão com Auth nos paramêtros
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Basic YWRtaW46QWxlc2V0aCFAIw=='
};

class ServerAluno {
  static Future<void> cadastrarAluno(Aluno aluno) async {
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

  static Future<void> valPresenAluno(Aluno aluno) async {
    try {
      String url_Api = 'https://apiseth.cyclic.app/validaPresenca';
      var request = http.Request('POST', Uri.parse(url_Api));
      request.body = json.encode({
        "id": aluno.id,
      });

      print(aluno.id);
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

  static Future<String> buscaAlunoId(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaAlunoId'));
    request.body = await json.encode({"usuario": aluno.usuario});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String id = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("Conexão estabelecida! valor retornado: $id ");
    } else {
      print(response.reasonPhrase);
    }

    return id;
  }

  static Future<void> iniciaProgresso(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/iniciaProgresso'));
    request.body = json.encode({"id": aluno.id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("Cadastro Concluido");
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<bool> verificaUsuario(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaUsuarioAluno'));
    request.body = json.encode({"usuario": aluno.usuario});

    print(aluno.usuario);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("O usuario digitado foi encontrado!");
      return true;
    } else {
      print(response.reasonPhrase);
      print("O usuario digitado não foi encontrado!");
      return false;
    }
  }

  static Future<String> logaUsuario(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/loginUsuario'));
    request.body =
        json.encode({"usuario": aluno.usuario, "senha": aluno.senha});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String nivelAcess = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("Usuario encontrado!");
      PrefsService.save(aluno.usuario!);
    } else {
      print(response.reasonPhrase);
    }

    return nivelAcess;
  }
}
