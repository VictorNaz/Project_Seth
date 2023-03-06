import 'package:flutter/material.dart';

import '../widgets/utilClass.dart';
import 'RedifSenha.dart';

class RecSenha extends StatefulWidget {
  const RecSenha({Key? key}) : super(key: key);
  @override
  State<RecSenha> createState() => _RecSenhaState();
}

class _RecSenhaState extends State<RecSenha> {
  @override
  Widget build(BuildContext context) {
    //Detecta a ára fora dos campos
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          //Foco primario
          //Desfocar
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          //Barra superior já com o icone de voltar
          backgroundColor: const Color.fromARGB(255, 252, 72, 27),
          title: const Text("Menu"),

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
       
        body: Stack(alignment: Alignment.center, children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                //Corpo superior, Icone e mensagem de bem vindo
                const Padding(padding: EdgeInsets.only(top: 40)),
                Image.asset(
                  'assets/image/logomarca.png',
                  height: 200,
                ),

                const Padding(padding: EdgeInsets.only(top: 30)),

                const Text(
                  "Digite seu e-mail para recuperar sua senha!",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),

                const Padding(padding: EdgeInsets.only(top: 50)),

                SizedBox(
                  width: 325,
                  child: TextFormField(
                    //Define o teclado para digitar e-mail(adiciona o @ no teclado)
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 252, 72, 27),
                        size: 35,
                      ),
                      labelText: "Email",
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 252, 72, 27))),
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(top: 220)),

                //Botão Enviar
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RedSenha()),
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
                      "Enviar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
