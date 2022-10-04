class Professor {
  int? id;
  String? nome;
  String? usuario;
  String? senha;
  String? email;
  String? cpf;

  int? get getId {
    return id;
  }

  set setId(int id) {
    this.id = id;
  }

  String? get getNome {
    return nome;
  }

  set setNome(String nome) {
    this.nome = nome;
  }

  String? get getUsuario {
    return usuario;
  }

  set setUsuario(String usuario) {
    this.usuario = usuario;
  }

  String? get getSenha {
    return senha;
  }

  set setSenha(String senha) {
    this.senha = senha;
  }

  String? get getEmail {
    return email;
  }

  set setEmail(String email) {
    this.email = email;
  }

  String? get getCpf {
    return cpf;
  }

  set setCpf(String cpf) {
    this.cpf = cpf;
  }
}
