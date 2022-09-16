import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';

String? cadAluno(String txtNome, String txtUsuario, String txtSenha,
    String txtEmail, String txtCpf) {
  var aluno = Aluno();

  aluno.setNome = txtNome;
  aluno.setUsuario = txtUsuario;
  aluno.setSenha = txtSenha;
  aluno.setEmail = txtEmail;
  aluno.setCpf = txtCpf;
}

String? _validarNome(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.isEmpty) {
    return "Informe o nome";
  } else if (!regExp.hasMatch(value)) {
    return "O nome deve conter caracteres de a-z ou A-Z";
  }
  return null;
}
