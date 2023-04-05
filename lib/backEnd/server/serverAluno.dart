import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';
import 'package:flutter_project_seth/backEnd/modelo/faixa.dart';
import 'package:flutter_project_seth/backEnd/security/sessionService.dart';
import 'package:http/http.dart' as http;

import '../modelo/autoAvaliacao.dart';

//Escopo padrão com Auth nos paramêtros
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Basic YWRtaW46QWxlc2V0aCFAIw=='
};

//cadastra o aluno no banco de dados
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

  //valida a presença do aluno no banco
  static Future<void> valPresenAluno(Aluno aluno) async {
    try {
      String url_Api = 'https://apiseth.cyclic.app/validaPresenca';
      var request = http.Request('POST', Uri.parse(url_Api));
      request.body = json.encode({
        "id": aluno.id,
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

  static Future<void> atualizaProgresso(Aluno aluno) async {
    try {
      String url_Api = 'https://apiseth.cyclic.app/atualizaProgresso';
      var request = http.Request('POST', Uri.parse(url_Api));
      request.body = json.encode({
        "aluno_id": aluno.id,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print("Progresso atualizado com sucesso!!");
      } else {
        print(response.reasonPhrase);
        print("Erro ao atualizar o progresso!!");
      }
    } catch (e, url_Api) {
      throw Exception(
          'Conexão não estabelecida! Não foi possivel se conectar ao endereço $url_Api.\n Erro $e');
    }
  }

  //busca o id do aluno recebendo o usuario dele
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

  //busca a quantidade de aulas que o aluno já frequentou
  static Future<int?> buscaAulas(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaAulas'));
    request.body = await json.encode({"aluno_id": aluno.id});
    request.headers.addAll(headers);

    var aulas = Faixa();

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Quantidade de aulas encontrada!");
      String jsonString = await response.stream.bytesToString();
      var result = await json.decode(jsonString);
      aulas.quantAulas = result["quant_aula"];
    } else {
      print("Erro ao procurar a quantidade de aulas");
      print(response.reasonPhrase);
    }

    return aulas.quantAulas;
  }

  //busca todos os alunos no banco de dados
  static Future<List> buscaAlunos() async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaAlunos'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    var lista = [];

    if (response.statusCode == 200) {
      //converte os dados do banco em String
      String jsonString = await response.stream.bytesToString();
      //converto os dados obtidos em um objeto JSON
      var result = await json.decode(jsonString);
      //for in para adicionar os resultados em um array
      for (var list in result) {
        lista.add(list["usuario"]);
      }

      print("Alunos encontrados!");
      return lista;
    } else {
      print("Erro ao procurar os alunos");
      print(response.reasonPhrase);
      return lista;
    }
  }

  //busca a auto-avaliação do aluno
  static Future<AutoAvaliacao> buscaAvaliacao(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscarAvaliacao'));
    request.body = json.encode({"aluno_id": aluno.id});
    request.headers.addAll(headers);

    var avaliacao = AutoAvaliacao();

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      var result = await json.decode(jsonString);
      avaliacao.alimentacao = result["alimentacao"];
      avaliacao.atividade_fisica = result["atividade_fisica"];
      avaliacao.auto_controle = result["auto_controle"];
      avaliacao.defesa_pessoal = result["defesa_pessoal"];
      avaliacao.relacionamento = result["relacionamento"];
      avaliacao.espiritual = result["espiritual"];
      avaliacao.prevencao = result["prevencao"];
      print("Avaliação encontrada com sucesso!");
      return avaliacao;
    } else {
      print(response.reasonPhrase);
      print("Erro ao encontrar a avaliação!");
      return avaliacao;
    }
  }

  //inicia o progresso do aluno quando ele é cadastrado
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

  //verifica se o usuario já existe no banco
  static Future<bool> verificaUsuario(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaUsuarioAluno'));
    request.body = json.encode({"usuario": aluno.usuario});

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

  //procura o usuario e senha digitados no banco e loga o usuario

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
      bool bol = await PrefsService.logout();
      PrefsService.save(aluno.usuario!);
      var teste = await PrefsService.returnUser();
    } else {
      print(response.reasonPhrase);
    }

    return nivelAcess;
  }

  //cadastra a auto-avaliação do aluno
  static Future<void> cadAvaliacao(Aluno aluno, List avaliacao) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/cadAvaliacao'));
    request.body = json.encode({
      "aluno_id": aluno.id,
      "alimentacao": avaliacao[0],
      "prevencao": avaliacao[1],
      "atividade_fisica": avaliacao[2],
      "auto_controle": avaliacao[3],
      "relacionamento": avaliacao[4],
      "espiritual": avaliacao[5],
      "defesa_pessoal": avaliacao[6],
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("Avaliação cadastrada com sucesso");
    } else {
      print(response.reasonPhrase);
      print("Erro ao cadastrar a avaliação");
    }
  }

  static Future<Aluno> buscaInfo(Aluno aluno) async {
    var request =
        http.Request('POST', Uri.parse('https://apiseth.cyclic.app/buscaInfo'));
    request.body = json.encode({"usuario": aluno.usuario});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var info = Aluno();

    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      var result = await json.decode(jsonString);

      info.nome = result["nome"];
      info.email = result["email"];
      info.cpf = result["cpf"];
      info.faixa_id = result["faixa_id"];
      print("Informações encontradas encontrados!");
      return info;
    } else {
      print("Erro ao procurar as informações!");
      print(response.reasonPhrase);
      return info;
    }
  }

  static Future<bool> buscaUsuarioPorEmail(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaUsuarioPorEmail'));
    request.body = json.encode({"email": aluno.email});
    request.headers.addAll(headers);

    var info = Aluno();
    print('$request : Request Print 286');

    http.StreamedResponse response = await request.send();
    print(
        '${response.reasonPhrase} ${response.contentLength} : Response Print 288');

    String jsonString = await response.stream.bytesToString();

    if (response.contentLength != 0) {
      print("E-mail já utilizado!");
      print(response.reasonPhrase);
      return true;
    } else if (response.statusCode == 200 || response.contentLength == 0) {
      print("Informações encontradas encontrados!");
      return false;
    } else {
      print("Erro ao procurar as informações!");
      print(response.reasonPhrase);
      return true;
    }
  }

  static Future<bool> buscaUsuarioPorUsuario(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaUsuarioPorUsuario'));
    request.body = json.encode({"usuario": aluno.usuario});
    request.headers.addAll(headers);

    var info = Aluno();
    print('$request : Request Print 286');

    http.StreamedResponse response = await request.send();
    print(
        '${response.reasonPhrase} ${response.contentLength} : Response Print 288');

    String jsonString = await response.stream.bytesToString();

    if (response.contentLength != 0) {
      print("Usuário já utilizado!");
      print(response.reasonPhrase);
      return true;
    } else if (response.statusCode == 200 || response.contentLength == 0) {
      print("Informações encontradas encontrados!");
      return false;
    } else {
      print("Erro ao procurar as informações!");
      print(response.reasonPhrase);
      return true;
    }
  }

  static Future<Faixa> buscaFaixa(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaFaixa'));
    request.body = json.encode({"faixa_id": aluno.faixa_id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var progresso = Faixa();

    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      var result = await json.decode(jsonString);
      String quantAula = result["quantidade_aulas"];
      progresso.faixa = result["nome"];
      int grau = result["grau"];
      //Converte o int em String 
      progresso.grau = grau.toString();
      //Converte um String em int?
      int? quantAulaInt = int.tryParse(quantAula);
      print(quantAulaInt);
      progresso.quantAulas = quantAulaInt;

      print("Progresso encontrado com sucesso!");
      return progresso;
    } else {
      print("Erro ao procurar o progresso!");
      print(response.reasonPhrase);
      return progresso;
    }
  }
}
