import 'package:flutter/cupertino.dart';

class Filial {
  Filial(
      {required this.id,
      required this.nome,
      required this.cep,
      required this.cnpj});

  int id;
  String nome;
  int cep;
  int cnpj;

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

  int get getCep {
    return cep;
  }

  set setCep(int cep) {
    this.cep = cep;
  }

  int get getCnpj {
    return cnpj;
  }

  set setCnpj(int cnpj) {
    this.cnpj = cnpj;
  }
}
