import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_seth/backEnd/modelo/aluno.dart';

class CtrlAluno {
  String nome;
  String usuario;
  String senha;
  String email;
  String cpf;

  CtrlAluno(this.nome, this.usuario, this.senha, this.email, this.cpf);
}
