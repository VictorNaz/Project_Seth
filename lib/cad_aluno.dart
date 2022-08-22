// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class CadAluno extends StatefulWidget {
  const CadAluno({Key? key}) : super(key: key);
  @override
  State<CadAluno> createState() => _CadAlunoState();
}

class _CadAlunoState extends State<CadAluno> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //Barra superior já com o icone de voltar
          backgroundColor: const Color.fromARGB(255, 252, 72, 27),
          actions: [],
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 40)),
              const SizedBox(
                width: 325,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Nome",
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 252, 72, 27))),
                  ),
                ),
              ),
              const SizedBox(
                width: 325,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 252, 72, 27))),
                  ),
                ),
              ),
              const SizedBox(
                width: 325,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "CPF",
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 252, 72, 27))),
                  ),
                ),
              ),
              const SizedBox(
                width: 325,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Senha",
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 252, 72, 27))),
                  ),
                ),
              ),
              const SizedBox(
                width: 325,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Confirmar Senha",
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 252, 72, 27))),
                  ),
                ),
              ),
              TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                    fixedSize: const Size(330, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ), //texto do button e estilo da escrita
                  child: const Text(
                    "Cadastrar-se",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ],
          ),
        ));
  }
}
