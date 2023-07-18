import 'dart:async';
import 'dart:convert';
import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';
import 'package:flutter_project_seth/backEnd/modelo/faixa.dart';
import 'package:flutter_project_seth/backEnd/modelo/progresso.dart';
import 'package:flutter_project_seth/backEnd/security/sessionService.dart';
import 'package:http/http.dart' as http;
import '../modelo/autoAvaliacao.dart';
import '../modelo/notificacoes.dart';

//!Escopo padrão com Auth nos paramêtros
var headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Basic YWRtaW46QWxlc2V0aCFAIw=='
};

//Classe de transações com a API para operações com alunos
class ServerAluno {
  //Cadastra o aluno no banco de dados
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

  //Valida a presença do aluno no banco
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

  //Atualiza o progresso do aluno, altera o valor do id da tabela de faixas
  static Future<void> atualizaProgresso(String? idAluno) async {
    try {
      String url_Api = 'https://apiseth.cyclic.app/atualizaProgresso';
      var request = http.Request('POST', Uri.parse(url_Api));
      request.body = json.encode({
        "aluno_id": idAluno,
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

  //Atualiza a quant de aulas feitas no progresso da faixa
  static Future<void> atualizaQuantAulas(String? idAluno) async {
    try {
      String url_Api = 'https://apiseth.cyclic.app/atualizaAulas';
      var request = http.Request('POST', Uri.parse(url_Api));
      request.body = json.encode({
        "aluno_id": idAluno,
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

  //Busca o id do aluno recebendo o usuario dele
  static Future<String> buscaAlunoId(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaAlunoId'));
    request.body = await json.encode({"usuario": aluno.usuario});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String id = await response.stream.bytesToString();
    print(id);
    if (response.statusCode == 200) {
      print("Conexão estabelecida! valor retornado: $id ");
    } else {
      print(response.reasonPhrase);
    }
    return id;
  }

  //Busca o usuario pelo nome do aluno
  /* static Future<String?> buscaUsarioPorNome(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaUsuarioPorNome'));
    request.body = await json.encode({"nome": aluno.nome});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    aluno.usuario = await json.decode(jsonString);

    if (response.statusCode == 200) {
      print("Conexão estabelecida! valor retornado: $aluno.usuario ");
    } else {
      print(response.reasonPhrase);
    }

    return aluno.usuario;
  }
*/
  //Busca a quantidade de aulas que o aluno já frequentou
  static Future<Progresso> buscaAulas(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaAulas'));
    request.body = json.encode({"aluno_id": aluno.id});
    request.headers.addAll(headers);

    var progAluno = Progresso();

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Quantidade de aulas encontrada!");
      String jsonString = await response.stream.bytesToString();
      var result = await json.decode(jsonString);
      progAluno.quant_aula = result["quant_aula"];
      progAluno.data_faixa = result["data_faixa"];
    } else {
      print("Erro ao procurar a quantidade de aulas");
      print(response.reasonPhrase);
    }
    return progAluno;
  }

  //Busca todos os alunos no banco de dados
  static Future buscaAlunos() async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaAlunos'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //converte os dados do banco em String
      String jsonString = await response.stream.bytesToString();
      var result = await json.decode(jsonString)
          as List; //identificar o tamanho do result
      // print(result);

      var listaAlu = ListaAlu(result);
      List<Aluno> listaAluno = [];

      listaAlu.aluno.forEach((element) {
        //   for (int i = 0; i < listaNotif.notificacoes.length; i++) {}
        //   p = p + 1;
        Aluno aluno = Aluno(
          // element['id'],
          element['nome'],
          element['usuario'],
          element['email'],
          //element['faixa_id'],
          //element['nivel_acess'],
        );
        listaAluno.add(aluno);

        print(listaAlu.aluno.length);
      });

      return listaAluno;
    } else {
      print(response.reasonPhrase);
      return null; //ajusttar
    }

/*
    var lista = [];

    if (response.statusCode == 200) {
      //converte os dados do banco em String
      String jsonString = await response.stream.bytesToString();
      //converto os dados obtidos em um objeto JSON
      var result = await json.decode(jsonString);
      print(result);
      //for in para adicionar os resultados em um array
      for (var list in result) {
        lista.add(list["nome"]);
      }

      print("Alunos encontrados!");
      print(lista);
      return lista;
    } else {
      print("Erro ao procurar os alunos");
      print(response.reasonPhrase);
      return lista;
    }

*/
  }

  //Busca a auto-avaliação do aluno
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

  //Inicia o progresso do aluno quando ele é cadastrado
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

  //Verifica se o usuario já existe no banco
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

  //Procura o usuario e senha digitados no banco e loga o usuario
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

  //Busca informações do aluno pelo usuario do aluno e retorna as informações
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
      info.usuario = result["usuario"];
      info.nome = result["nome"];
      info.email = result["email"];
      int nivel_acess = result["nivel_acess"];
      info.nivel_acess = nivel_acess.toString();
      info.cpf = result["cpf"];
      info.faixa_id = result["faixa_id"];
      int? idUser = result["id"];
      info.id = idUser.toString();
      print("Informações encontradas encontrados!");
      return info;
    } else {
      print("Erro ao procurar as informações!");
      print(response.reasonPhrase);
      return info;
    }
  }

  //Busca o usuário pelo e-mail
  static Future<bool> buscaUsuarioPorEmail(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaUsuarioPorEmail'));
    request.body = json.encode({"email": aluno.email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(
        '${response.reasonPhrase} ${response.contentLength} : Response Print 288');

    if (response.contentLength != 0) {
      print("E-mail já utilizado!");
      print(response.reasonPhrase);
      return true;
    } else if (response.statusCode == 200 || response.contentLength == 0) {
      return false;
    } else {
      print("Erro ao procurar as informações!");
      print(response.reasonPhrase);
      return true;
    }
  }

  //Busca o usuario do aluno no BD, e valida se já existe
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

  //Busca informações sobre a faixa do aluno
  static Future<Faixa> buscaFaixa(Aluno aluno) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaFaixa'));
    request.body = json.encode({"faixa_id": aluno.faixa_id});
    request.headers.addAll(headers);
    print(aluno.faixa_id);
    http.StreamedResponse response = await request.send();
    var progresso = Faixa();

    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      print(jsonString);
      var result = await json.decode(jsonString); //parou
      String quantAula = result["quantidade_aulas"];
      progresso.faixa = result["nome"];
      progresso.grau = result["grau"];
      //progresso.grau = grau.toString(); //!Converte o int em String
      int? quantAulaInt = int.tryParse(quantAula); //!Converte um String em int?
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

  //Registra do BD quando o aluno passa de faixa ou de grau, para gerar a notificação
  static Future<void> registraNotificacao(
      Aluno aluno, Faixa faixa, String isFaixa) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/registraNotificacao'));
    request.body = json.encode({
      "nome_aluno": aluno.nome,
      "usuario_aluno": aluno.usuario,
      "grau": faixa.grau,
      "faixa": faixa.faixa,
      "is_faixa": isFaixa
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(isFaixa);
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  //busca todos os alunos no banco de dados que possuem notificações disponiveis
  static Future buscaNotificacoes() async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/buscaNotificacoes'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //converte os dados do banco em String
      String jsonString = await response.stream.bytesToString();
      var result = await json.decode(jsonString)
          as List; //identificar o tamanho do result
      // print(result);

      String? is_Faixa;
      var listaNotif = ListaNoti(result);
      List<Notificacoes> listaNot = [];

      listaNotif.notificacoes.forEach((element) {
        //   for (int i = 0; i < listaNotif.notificacoes.length; i++) {}
        //   p = p + 1;

        if (element['is_faixa'] == 'true') {
          is_Faixa = 'Faixa';
        } else {
          is_Faixa = 'Grau';
        }

        Notificacoes notificacoes = Notificacoes(
            element['idnotificacoes'],
            element['usuario_aluno'],
            element['nome_aluno'],
            element['grau'],
            element['faixa'],
            is_Faixa);
        listaNot.add(notificacoes);

        print(listaNotif.notificacoes.length);
      });

      return listaNot;
    } else {
      print(response.reasonPhrase);
      return null; //ajusttar
    }
  }

  //Exclui a notificação que foi selecionada na tela de notificações
  static Future<bool> excluiNotificacao(int idnotificacoes) async {
    var request = http.Request(
        'DELETE', Uri.parse('https://apiseth.cyclic.app/excluiNotificacao'));
    request.body = json.encode({
      "idnotificacoes": idnotificacoes,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("Notificação deletada");
      return true;
    } else {
      print(response.reasonPhrase);
      print("Erro Deletar notificação");

      return false;
    }
  }

  //Valida o usuário e senha enviados ao BD
  static Future<bool> validaCredenciais(String usuario, String senha) async {
    var request = http.Request(
        'POST', Uri.parse('https://apiseth.cyclic.app/validaCredenciais'));
    request.body = json.encode({
      "usuario": usuario,
      "senha": senha,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonString = await response.stream.bytesToString();
      //! Se não encontrar o aluno, vai trazer somente "[]"
      int count = jsonString.length;
      if (jsonString.length <= 2) {
        return false; //!Não encontrou nada com aquele usuário e senha
      } else {
        return true; //!Encontrou aquele usuário e senha
      }
    }
    return false;
  }

  //Atualiza a quant de aulas feitas no progresso da faixa
  static Future<bool> recuperaSenha(String? emailAluno, String senha) async {
    try {
      String url_Api = 'https://apiseth.cyclic.app/recuperaSenha';
      var request = http.Request('POST', Uri.parse(url_Api));
      request.body = json.encode({
        "email": emailAluno,
        "senha": senha,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        return true;
      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e, url_Api) {
      throw Exception(
          'Conexão não estabelecida! Não foi possivel se conectar ao endereço $url_Api.\n Erro $e');
    }
  }
}//Fim da classe
