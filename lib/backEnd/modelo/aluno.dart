// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Aluno {
  String? id;
  String? nome;
  String? usuario;
  String? senha;
  String? email;
  String? cpf;
  int? faixa_id;
  String? nivel_acess;
  String? foto;

  Aluno([this.nome, this.usuario, this.email, this.foto]);

  String? get getId {
    return id;
  }

  set setId(String id) {
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

  String? get getNivel_acess {
    return nivel_acess;
  }

  set setNivel_acess(String nivel_acess) {
    this.nivel_acess = nivel_acess;
  }

  String? get getFoto {
    return foto;
  }

  set setFoto(String foto) {
    this.foto = foto;
  }
}

class ListaAlu {
  List aluno = [];

  ListaAlu(this.aluno);
}
