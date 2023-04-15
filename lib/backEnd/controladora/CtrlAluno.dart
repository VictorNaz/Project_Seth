import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';
import 'package:flutter_project_seth/backEnd/modelo/faixa.dart';
import 'package:flutter_project_seth/backEnd/modelo/progresso.dart';
import 'package:flutter_project_seth/backEnd/security/dataCrypt.dart';
import 'package:flutter_project_seth/backEnd/security/sessionService.dart';
import 'package:flutter_project_seth/backEnd/server/serverAluno.dart';
import 'package:flutter_project_seth/frontEnd/widgets/utilClass.dart';

import '../modelo/autoAvaliacao.dart';

/********************** CLASSES DE CONTROLE  **************************/

//Cadastra aluno
void cadAluno(String txtNome, String txtUsuario, String txtSenha,
    String txtEmail, String txtCpf) async {
  var aluno = Aluno();

  aluno.setNome = txtNome;
  aluno.setUsuario = txtUsuario;
  var novaSenha = dataCrypt(txtSenha);
  aluno.setSenha = novaSenha;
  aluno.setEmail = txtEmail;
  aluno.setCpf = txtCpf;

  await ServerAluno.cadastrarAluno(aluno);
  aluno.id = await ServerAluno.buscaAlunoId(aluno);
  await ServerAluno.iniciaProgresso(aluno);
}

//Valida Presença do aluno
void validaPresAluno() async {
  var txtUsuario = await PrefsService.returnUser();
  var aluno = Aluno();
  var faixa = Faixa();
  String? usr = txtUsuario;
  aluno.setUsuario = usr!;

  String? idAluno = await ServerAluno.buscaAlunoId(aluno);
  //Teve de ser adicionado a uma variável, pois ao receber um novo valor, o usuário perdia o aluno.id
  aluno = await ServerAluno.buscaInfo(aluno);
  await ServerAluno.valPresenAluno(aluno);
  await ServerAluno.atualizaProgresso(aluno);
  faixa = await ServerAluno.buscaFaixa(aluno);
  aluno.id = idAluno;
  int? aulasPendentes = faixa.quantAulas;
  int? aulasFeitas = await ServerAluno.buscaAulas(aluno);

  if (aulasFeitas == aulasPendentes) {
    //Verifica se o aluno alcançou a meta de aulas para o seu faixa_id
    await ServerAluno.registraNotificacao(aluno, faixa);
    NotificationService(aluno, faixa);
    if (txtUsuario == 'admin') {
      print(txtUsuario);
      //Passada as informações do aluno e de sua faixa
      NotificationService(aluno, faixa);
    } else {
      print("nivel");
      print(aluno.usuario);
      null;
    }
  }
}

//Login de Usuario
Future<String?> loginUsuario(String txtUsuario, String txtSenha) async {
  var aluno = Aluno();
  var novaSenha = dataCrypt(txtSenha);
  aluno.setUsuario = txtUsuario;
  aluno.setSenha = novaSenha;

  aluno.nivel_acess = await ServerAluno.logaUsuario(aluno);
  return aluno.nivel_acess;
}

void cadAvaliacao(
    double valAlimentacao,
    double valPrevencao,
    double valAtivFisica,
    double valAutoControle,
    double valRelacionamento,
    double valEspiritual,
    double valDefPessoal) async {
  List avaliacao = [
    valAlimentacao,
    valPrevencao,
    valAtivFisica,
    valAutoControle,
    valRelacionamento,
    valEspiritual,
    valDefPessoal
  ];
  var aluno = Aluno();

  aluno.usuario = await PrefsService.returnUser();
  aluno.id = await ServerAluno.buscaAlunoId(aluno);
  await ServerAluno.cadAvaliacao(aluno, avaliacao);
}

//busca a auto-avaliação do aluno
Future<List<double>> buscaAvaliacao(Aluno aluno) async {
  //var aluno = Aluno();
  var avaliacao = AutoAvaliacao();
  //aluno.usuario = await PrefsService.returnUser();
  aluno.id = await ServerAluno.buscaAlunoId(aluno);
  avaliacao = await ServerAluno.buscaAvaliacao(aluno);

  double alimentacao = avaliacao.alimentacao!.toDouble();
  double prevencao = avaliacao.prevencao!.toDouble();
  double atividadeFisica = avaliacao.atividade_fisica!.toDouble();
  double autoControle = avaliacao.auto_controle!.toDouble();
  double relacionamento = avaliacao.relacionamento!.toDouble();
  double espiritual = avaliacao.espiritual!.toDouble();
  double defesaPessoal = avaliacao.defesa_pessoal!.toDouble();

  List<double> lista = [
    alimentacao,
    prevencao,
    atividadeFisica,
    autoControle,
    relacionamento,
    espiritual,
    defesaPessoal
  ];
  return lista;
}

//Busca a quantidade de aulas frequentadas
Future<int?> buscaAulas(Aluno aluno) async {
  //var aluno = Aluno();
  var aulas = Faixa();
  //aluno.usuario = await PrefsService.returnUser();
  aluno.id = await ServerAluno.buscaAlunoId(aluno);
  aulas.quantAulas = await ServerAluno.buscaAulas(aluno);

  return aulas.quantAulas;
}

Future<Aluno> buscaInfo(Aluno aluno) async {
  aluno = await ServerAluno.buscaInfo(aluno);
  print(aluno.email);
  return aluno;
}

Future<bool> buscaUsuarioPorEmail(String email) async {
  var aluno = Aluno();
  aluno.email = email;
  var existe = await ServerAluno.buscaUsuarioPorEmail(aluno);

  return existe;
}

Future<bool> buscaUsuarioPorUsuario(String usuario) async {
  var aluno = Aluno();
  aluno.usuario = usuario;
  var existe = await ServerAluno.buscaUsuarioPorUsuario(aluno);

  return existe;
}

Future<Faixa> buscaFaixa(Aluno aluno) async {
  var progresso = Faixa();
  progresso = await ServerAluno.buscaFaixa(aluno);

  return progresso;
}

/*************************** VALIDAÇÕES DE CAMPO *******************************/

String? validarNome(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty || value == null) {
    return "Informe o Nome";
  } else if (!regExp.hasMatch(value)) {
    return "O nome deve conter caracteres de a-z ou A-Z";
  }
  return null;
}

String? validarEmail(String value) {
  /* var aluno = Aluno();
  aluno.email = value;
  buscaUsuarioPorEmail(aluno);*/
  String patttern = r'(^[\.-_A-zÀ-ü0-9]{1,}[@]{1}[A-z]{2,}([.]{1}[A-z]{1,})+$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty || value == null) {
    return "Informe o Email";
  } else if (!regExp.hasMatch(value)) {
    return "O Email digitado não é válido";
    /*} else if (value == aluno.email) {
    return "O E-mail digitado já pertence a outro usuário!";*/
  }
  return null;
}

String? validarSenha(String value) {
  if (value.isEmpty || value.length < 6) {
    return "Informe uma senha com no mínimo 6 caracteres";
  }
  return null;
}

String? validarConfSenha(String txtSenha, String txtConfSenha) {
  if (txtSenha.isEmpty || txtSenha.length < 6) {
    return "Informe uma senha com no mínimo 6 caracteres";
  }
  if (txtSenha != txtConfSenha) {
    return "Esta senha é diferente da digitada acima!";
  }

  return null;
}

String? validaCpf(String value) {
  String patttern = r'(^[0-9]{11}$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty || value == null) {
    return "Informe o CPF";
  } else if (!regExp.hasMatch(value)) {
    return "O CPF digitado não é válido";
  }
  return null;
}

String? validaUsuario(String value) {
  String patttern = r'(^[a-z]*$)';
  RegExp regExp = RegExp(patttern);
  var aluno = Aluno();
  aluno.usuario = value;
  if (value.isEmpty) {
    return "O campo usuário não ser vazio!";
  } else if (!regExp.hasMatch(value)) {
    return "O usuário de acesso precisa estar em minúsculo!";
  }
  return null;
}

String? validaQtdeAulas(String value) {
  if (value.isEmpty) {
    return "Informe o número de aulas!";
  }
  return null;
}

String? validaSenhaLogin(String value) {
  if (value.isEmpty) {
    return "Informe a senha!";
  }
  return null;
}

Future<bool> duplicaEmail(String value) async {
  var aluno = Aluno();
  aluno.email = value;

  print(aluno.usuario);
  if (aluno.usuario == null) {
    return false;
    //Email não cadastrado
  } else {
    return true;
    //Email cadastrado, encontrou usuário realizando a pesquisa pelo email
  }
}
