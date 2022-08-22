import 'package:flutter/material.dart';

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
        body: Center(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 100)),
              Image.asset(
                'assets/image/logomarca.png',
                height: 200,
              ),
<<<<<<< HEAD
              const Text("Seja bem-vindo!",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold)),
              const Text("Coloque suas informações de login.",
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ));
=======
              const Text("Seja bem-vindo!", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              const Text("Coloque suas informações de login.", style: TextStyle(color: Colors.grey)), 
              
              //SizedBox vazia somente para dar espacamento entre texto de boas vindas e campos de input
              const SizedBox(
                height: 70,
              ),

              //SizedBox() adicionado para dimencionar os campos input
              //Campo email
              const SizedBox(
                width: 325,
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person_outline, color: Color.fromARGB(255, 252, 72, 27)),
                    hintText: "E-mail",
                    hintStyle: TextStyle(color: Colors.black),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 252, 72, 27))),
                  ),
                ),
              ),

              //Campo Senha
              const SizedBox(
              width: 325,
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline, color: Color.fromARGB(255, 252, 72, 27)),
                  hintText: "Senha",
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 252, 72, 27))),
                ),
              ),
            ),
          ],
        ),
      )
    );
>>>>>>> 53f48819492675bdb503c68e5bb3466d03c1cc71
  }
}


/*
              const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person_outline, color: Color.fromARGB(255, 252, 72, 27)),
                  hintText: "E-mail",
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 252, 72, 27))),
                  ),
                
                ), 
                
            */
  