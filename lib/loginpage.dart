import 'package:flutter/material.dart';
import 'package:flutter_project_seth/cadAluno.dart';
import 'package:flutter_project_seth/menuPrincipal.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //Barra superior já com o icone de voltar
          backgroundColor: const Color.fromARGB(255, 252, 72, 27),
          actions: const [],
        ),

        //Corpo já centralizado
        body: Center(
          child: Column(
            children: [
              //Corpo superior, Icone e mensagem de bem vindo
              const Padding(padding: EdgeInsets.only(top: 50)),
              Image.asset(
                'assets/image/logomarca.png',
                height: 200,
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Text("Seja bem-vindo!",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold)),
              const Text("Coloque suas informações de login.",
                  style: TextStyle(color: Colors.grey)),

              //Espaçamento entre o corpo superior e os inputs
              const Padding(padding: EdgeInsets.only(top: 70)),

              //Campo email
              const SizedBox(
                width: 325,
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person_outline,
                        color: Color.fromARGB(255, 252, 72, 27)),
                    hintText: "E-mail",
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 252, 72, 27))),
                  ),
                ),
              ),

              //Espaçamento entre inputs
              const Padding(padding: EdgeInsets.only(top: 15)),

              //Campo Senha
              const SizedBox(
                width: 325,
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline,
                        color: Color.fromARGB(255, 252, 72, 27)),
                    hintText: "Senha",
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 252, 72, 27))),
                  ),
                ),
              ),

              //Espaçamento entre o campo senha e o button entrar
              const Padding(padding: EdgeInsets.only(top: 50)),

              //Botão entrar
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Menu()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                    fixedSize: const Size(330, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ), //texto do button e estilo da escrita
                  child: const Text(
                    "Entrar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              //espaçamento entre o button entrar em o Recuperar senha
              const Padding(padding: EdgeInsets.only(top: 40)),

              //Campo Recuperar senha
              TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    fixedSize: const Size(330, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ), //texto do button e estilo da escrita
                  child: const Text(
                    "Recuperar senha",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )),

              //Campo cadastrar-se
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CadAluno()),
                    );
                  },
                  style: TextButton.styleFrom(
                    fixedSize: const Size(330, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ), //texto do button e estilo da escrita
                  child: const Text(
                    "Cadastrar-se",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  )),
            ],
          ),
        ));
  }
}
