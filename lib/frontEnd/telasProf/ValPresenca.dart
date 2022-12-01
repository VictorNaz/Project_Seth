import 'package:flutter/material.dart';
import '../../backEnd/controladora/CtrlAluno.dart';
import '../widgets/utilClass.dart';

class ValPresenca extends StatefulWidget {
  const ValPresenca({Key? key}) : super(key: key);
  @override
  State<ValPresenca> createState() => _ValPresencaState();
}

class _ValPresencaState extends State<ValPresenca> {
  bool showPassword = false;

  TextEditingController txtUsuario = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        endDrawer: const Drawer(
          child: DrawerTop(
            texto: "Opções",
          ),
        ),

        //Corpo já centralizado
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(),
            SingleChildScrollView(
              child: Column(
                children: [
                  //Corpo superior, Icone e mensagem de bem vindo
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Image.asset(
                    'assets/image/logomarca2.png',
                    height: 300,
                  ),

                  //texto
                  const Text("Presença",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),

                  //Espaçamento entre textos
                  const Padding(padding: EdgeInsets.only(top: 20)),

                  const Text(
                      "Para confirmar a sua presença \n" +
                          "digite o seu usuário no campo abaixo",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16)),

                  //Espaçamento entre o corpo superior e os inputs
                  const Padding(padding: EdgeInsets.only(top: 40)),

                  Form(
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
                                  color: Color.fromARGB(255, 252, 72, 27),
                                  size: 35),
                              labelText: "Usuário",
                              hintStyle: TextStyle(color: Colors.black),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 72, 27))),
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ])),

                  //espaçamento entre imput e button
                  const Padding(padding: EdgeInsets.only(top: 150)),

                  //Botão entrar
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          validaPresAluno(txtUsuario.text);
                          Navigator.pop(context, false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Presença Validada')),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                        fixedSize: const Size(330, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ), //texto do button e estilo da escrita
                      child: const Text(
                        "Validar Presença",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),

                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
