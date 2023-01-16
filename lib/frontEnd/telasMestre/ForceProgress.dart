import 'package:flutter/material.dart';

import '../widgets/utilClass.dart';

class ForceProgress extends StatefulWidget {
  const ForceProgress({Key? key}) : super(key: key);

  @override
  State<ForceProgress> createState() => _ForceProgressState();
}

class _ForceProgressState extends State<ForceProgress> {
  TextEditingController txtUsuario = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Text("Forçar Progresso"),

        //Icone de voltar quando utilizado o drawer no appbar
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context, false)),
      ),

      //drawer para navegação no appbar
      //A classe Drawer está sendo chamada de outro arquivo e está recebendo por parametro o texto desejado.
      endDrawer: const Drawer(
        child: DrawerTop(
          texto: "Opções",
        ),
      ),
      //botão flutuante sobre a barra inferior

      body: Form(
          key: _formKey,
          child: Column(children: [
            //Campo email
            SizedBox(
              width: 325,
              child: TextFormField(
                controller: txtUsuario,

                //foca no primeiro campo ao entrar na página
                autofocus: true,

                //Define o teclado para digitar e-mail(adiciona o @ no teclado)
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person_outline,
                      color: Color.fromARGB(255, 252, 72, 27), size: 35),
                  labelText: "Usuário",
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 252, 72, 27))),
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
          ])),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, false);
        },
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        elevation: 2.0,
        child: const Icon(
          Icons.home,
          color: Colors.black,
          size: 35,
        ),
      ),
      //barra infeirior
      bottomNavigationBar: const BotaoInferior(),
    );
  }
}
