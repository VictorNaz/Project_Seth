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
        body: Stack(alignment: Alignment.center, children: <Widget>[
          Container(),
          SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 70)),
                const Text("Insira os dados abaixo:",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                const Padding(padding: EdgeInsets.only(top: 40)),
                SizedBox(
                  width: 325,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Nome",
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 252, 72, 27))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 325,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 252, 72, 27))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 325,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "CPF",
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 252, 72, 27))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 325,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Senha",
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 252, 72, 27))),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  width: 325,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Confirmar Senha",
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 252, 72, 27))),
                    ),
                    obscureText: true,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 100)),
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
          )
        ]));
  }
}
