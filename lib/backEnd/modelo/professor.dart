class Professor {
  Professor(
      {required this.id,
      required this.nome,
      required this.usuario,
      required this.telefone,
      required this.senha,
      required this.email,
      required this.cpf});

  int id;
  String nome;
  String usuario;
  int telefone;
  int senha;
  String email;
  int cpf;

  int get getId {
    return id;
  }

  set setId(int id) {
    this.id = id;
  }

  String get getNome {
    return nome;
  }

  set setNome(String nome) {
    this.nome = nome;
  }

  String get getUsuario {
    return usuario;
  }

  set setUsuario(String usuario) {
    this.usuario = usuario;
  }

  int get getTelefone {
    return telefone;
  }

  set setTelefone(int telefone) {
    this.telefone = telefone;
  }

  int get getSenha {
    return senha;
  }

  set setSenha(int senha) {
    this.senha = senha;
  }

  String get getEmail {
    return email;
  }

  set setEmail(String email) {
    this.email = email;
  }

  int get getCpf {
    return cpf;
  }

  set setCpf(int cpf) {
    this.cpf = cpf;
  }
}
