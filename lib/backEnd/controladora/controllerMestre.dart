// ignore_for_file: file_names

import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';
import 'package:flutter_project_seth/backEnd/modelo/progresso.dart';
import 'package:flutter_project_seth/backEnd/security/dataCrypt.dart';
import 'package:flutter_project_seth/backEnd/server/serverProfessor.dart';

import '../modelo/faixa.dart';
import '../modelo/professor.dart';
import '../server/serverAluno.dart';

//CADASTRA O PROFESSOR
String? cadProfessor(String txtNome, String txtUsuario, String txtSenha,
    String txtEmail, String txtCpf) {
  var professor = Professor();

  professor.nome = txtNome;
  professor.usuario = txtUsuario;
  var novaSenha = dataCrypt(txtSenha);
  professor.senha = novaSenha;
  professor.email = txtEmail;
  professor.cpf = txtCpf;

  ServerProfessor.cadastrarProfessor(professor);
  return null;
}

Future<String?> forcaProgresso(String txtUsuario, String txtFaixa,
    String txtGrau, DateTime? dtTrocaFaixa) async {
  var faixa = Faixa();
  var progresso = Progresso();
  var aluno = Aluno();

  faixa.faixa = txtFaixa;
  progresso.data_faixa = dtTrocaFaixa.toString();
  faixa.grau = int.tryParse(txtGrau);
  aluno.usuario = txtUsuario;
  aluno.id = await ServerAluno.buscaAlunoId(aluno);
  faixa.id = await ServerProfessor.buscaFaixaId(faixa);
  ServerProfessor.forcaProgresso(aluno, faixa, progresso);
  return null;
}

//BUSCA OS ALUNOS CADASTRADOS PARA EXIBIR NA LISTA DE ALUNOS DO PROFESSOR
Future<List> buscaAlunos() async {
  var alunos = await ServerAluno.buscaAlunos();

  return alunos;
}

//BUSCA AS NOTIFICAÇÕES DISPONIVEIS
Future<List> buscaNotificacoes() async {
  List notificacao = await ServerAluno.buscaNotificacoes();
  return notificacao;
}

Future<String> validaPresencaSenha(String usuario, String senha) async {
  var aluno = Aluno();
  aluno.usuario = usuario;
  aluno = await ServerAluno.buscaInfo(aluno);
  String resposta;
  var novaSenha = dataCrypt(senha);
  bool retorno = await ServerAluno.validaCredenciais(usuario, novaSenha);
  if (retorno == true) {
    await ServerAluno.valPresenAluno(aluno);
    resposta = "Presença validada com sucesso!";
  } else {
    resposta = "Não foi possivel validar a presença, senha incorreta!";
  }
  return resposta;
}
/*************************** VALIDAÇÕES DE CAMPO *******************************/

String? validarNome(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty || value == null) {
    return "Informe o nome";
  } else if (!regExp.hasMatch(value)) {
    return "O nome deve conter caracteres de a-z ou A-Z";
  }
  return null;
}

String? validarEmail(String value) {
  String patttern = r'(^[\.-_A-zÀ-ü0-9]{1,}[@]{1}[A-z]{2,}([.]{1}[A-z]{1,})+$)';
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

String? validarCpf(String value) {
  String patttern = r'(^[0-9]{11}$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty || value == null) {
    return "Informe o CPF";
  } else if (!regExp.hasMatch(value)) {
    return "O CPF digitado não é válido";
  }
  return null;
}

String? validaProfessor(String value) {
  String patttern = r'(^[a-z]*$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty) {
    return "Informe o usuário";
  } else if (!regExp.hasMatch(value)) {
    return "O usuário de acesso precisa estar em minúsculo!";
  }
  return null;
}

String? ValidarTermos(String value) {
  if (value == true) {
    return "Informe o usuário";
  }
  return null;
}