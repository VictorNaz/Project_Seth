import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';
import 'package:flutter_project_seth/backEnd/modelo/faixa.dart';
import 'package:flutter_project_seth/backEnd/security/dataCrypt.dart';
import 'package:flutter_project_seth/backEnd/security/sessionService.dart';
import 'package:flutter_project_seth/backEnd/server/serverAluno.dart';

import '../modelo/autoAvaliacao.dart';

/********************** CLASSES DE CONTROLE  **************************/

//Cadastra aluno
Future<String?> cadAluno(String txtNome, String txtUsuario, String txtSenha,
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
Future<String?> validaPresAluno(String txtUsuario) async {
  var aluno = Aluno();
  aluno.setUsuario = txtUsuario;

  aluno.id = await ServerAluno.buscaAlunoId(aluno);
  await ServerAluno.valPresenAluno(aluno);
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

Future<String?> cadAvaliacao(
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
Future<List<double>> buscaAvaliacao() async {
  var aluno = Aluno();
  var avaliacao = AutoAvaliacao();
  aluno.usuario = await PrefsService.returnUser();
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
Future<int?> buscaAulas() async {
  var aluno = Aluno();
  var aulas = Faixa();
  aluno.usuario = await PrefsService.returnUser();
  aluno.id = await ServerAluno.buscaAlunoId(aluno);
  aulas.quantAulas = await ServerAluno.buscaAulas(aluno);

  return aulas.quantAulas;
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
  String patttern = r'(^[A-zÀ-ü]{1,}[@]{1}[A-z]{2,}([.]{1}[A-z]{1,})+$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty || value == null) {
    return "Informe o Email";
  } else if (!regExp.hasMatch(value)) {
    return "O Email digitado não é válido";
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
  if (value.isEmpty) {
    return "Informe o usuário!";
  }
  return null;
}

String? validaSenhaLogin(String value) {
  if (value.isEmpty) {
    return "Informe a senha!";
  }
  return null;
}
