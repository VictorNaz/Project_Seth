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
          actions: [],
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 100)),
              Image.asset(
                'assets/image/logomarca.png',
                height: 200,
              ),
              const Text("Seja bem-vindo!",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold)),
              const Text("Coloque suas informações de login.",
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ));
  }
}
