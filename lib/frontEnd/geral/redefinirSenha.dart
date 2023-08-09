import 'package:flutter/material.dart';

import '../widgets/utilClass.dart';
import 'loginPage.dart';

class RedSenha extends StatefulWidget {
  const RedSenha({Key? key}) : super(key: key);
  @override
  State<RedSenha> createState() => _RedSenhaState();
}

class _RedSenhaState extends State<RedSenha> {
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
          
          //Corpo já centralizado
          //Corpo já centralizado
          body: Stack(alignment: Alignment.center, children: <Widget>[
            Container(),
            SingleChildScrollView(
                //Subir o texto ao selecionar os inputs
                child: Column(
              children: [
                //Corpo superior, Icone e mensagem de bem vindo
                const Padding(padding: EdgeInsets.only(top: 20)),
                Image.asset(
                  'assets/image/logomarca.png',
                  height: 200,
                ),

                const Padding(padding: EdgeInsets.only(top: 20)),

                const Text(
                  "Redenifição de Senha",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),

                const Padding(padding: EdgeInsets.only(top: 40)),

                SizedBox(
                  width: 325,
                  child: TextFormField(
                    //Define o teclado para digitar e-mail(adiciona o @ no teclado)
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock_outline,
                          color: Color.fromARGB(255, 252, 72, 27), size: 35),
                      labelText: "Nova Senha",
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 252, 72, 27))),
                    ),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(top: 15)),

                SizedBox(
                  width: 325,
                  child: TextFormField(
                    //foca no primeiro campo ao entrar na página
                    autofocus: true,

                    //Define o teclado para digitar e-mail(adiciona o @ no teclado)
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock_outline,
                          color: Color.fromARGB(255, 252, 72, 27), size: 35),
                      labelText: "Confirmar Senha",
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
                            builder: (context) => const LoginPage()),
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

                const Padding(padding: EdgeInsets.only(top: 50)),
              ],
            ))
          ])),
    );
  }
}
