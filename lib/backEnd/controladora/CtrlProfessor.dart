import '../modelo/professor.dart';

String? cadProfessor(String txtNome, String txtUsuario, String txtTelefone,
    String txtSenha, String txtEmail, String txtCpf) {
  var professor = Professor();

  professor.nome = txtNome;
  professor.usuario = txtUsuario;
  professor.telefone = txtTelefone;
  professor.senha = txtSenha;
  professor.email = txtEmail;
  professor.cpf = txtCpf;
}

String? validarNome(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.isEmpty || value == null) {
    return "Informe o nome";
  } else if (!regExp.hasMatch(value)) {
    return "O nome deve conter caracteres de a-z ou A-Z";
  }
  return null;
}

String? validarEmail(String value) {
  String patttern = r'(^[A-zÀ-ü]{1,}[@]{1}[A-z]{2,}([.]{1}[A-z]{1,})+$)';
  RegExp regExp = new RegExp(patttern);
  if (value.isEmpty || value == null) {
    return "Informe o Email";
  } else if (!regExp.hasMatch(value)) {
    return "O Email digitado não é válido";
  }
  return null;
}

String? validarTelefone(String value) {
  String patttern = r'(^[0-9]{11}$)';
  RegExp regExp = new RegExp(patttern);
  if (value.isEmpty || value == null) {
    return "Informe o Telefone";
  } else if (!regExp.hasMatch(value)) {
    return "O Telefone digitado não é válido";
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
  RegExp regExp = new RegExp(patttern);
  if (value.isEmpty || value == null) {
    return "Informe o CPF";
  } else if (!regExp.hasMatch(value)) {
    return "O CPF digitado não é válido";
  }
  return null;
}

String? validaUsuario(String value) {
  if (value.isEmpty) {
    return "Informe o usuário";
  }
  return null;
}

String? ValidarTermos(String value) {
  if (value == true) {
    return "Informe o usuário";
  }
  return null;
}
