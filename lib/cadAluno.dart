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
          //Posicionamento do campo ao selecionar o campo
          SingleChildScrollView(
            child: Column(
              children: [
                const Text("Insira os dados abaixo:",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                const Padding(padding: EdgeInsets.only(top: 50)),
                SizedBox(
                  width: 325,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 252, 72, 27),
                      ),
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
                    //Define o teclado para digitar e-mail(adiciona o @ no teclado)
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 252, 72, 27),
                      ),
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
                    //Define o teclado para numérico
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.document_scanner,
                        color: Color.fromARGB(255, 252, 72, 27),
                      ),
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
                      icon: Icon(
                        Icons.password,
                        color: Color.fromARGB(255, 252, 72, 27),
                      ),
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
                      icon: Icon(
                        Icons.password,
                        color: Color.fromARGB(255, 252, 72, 27),
                      ),
                      labelText: "Confirmar Senha",
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 252, 72, 27))),
                    ),
                    obscureText: true,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 200)),
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
