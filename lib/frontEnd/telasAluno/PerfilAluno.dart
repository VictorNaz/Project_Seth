import 'package:flutter/material.dart';

import '../widgets/utilClass.dart';
import 'CadAluno.dart';
import 'MenuPrincipal.dart';

class PerfilAluno extends StatefulWidget {
  const PerfilAluno({Key? key}) : super(key: key);
  @override
  State<PerfilAluno> createState() => _PerfilAlunoState();
}

class _PerfilAlunoState extends State<PerfilAluno> {
  bool isChecked = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    //Detecta a ára fora dos campos
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          //Foco no campo primario
          //Desfocar
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBody: true,
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
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(),
            //Posicionamento do campo ao selecionar o campo
            SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/image/logomarca.png',
                    height: 200,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),

                  const Text("Informações do Usuário",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 26)),

                  const Padding(padding: EdgeInsets.only(top: 30)),

                  SizedBox(
                    width: 325,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 252, 72, 27),
                        ),
                        labelText: "Nome Completo",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 252, 72, 27))),
                      ),
                    ),
                  ),
                  //Espaçamento entre inputs
                  const Padding(padding: EdgeInsets.only(top: 15)),

                  SizedBox(
                    width: 325,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 252, 72, 27),
                        ),
                        labelText: "Usuário",
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 252, 72, 27))),
                      ),
                    ),
                  ),

                  //Espaçamento entre inputs
                  const Padding(padding: EdgeInsets.only(top: 15)),

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

                  //Espaçamento entre inputs
                  const Padding(padding: EdgeInsets.only(top: 15)),

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

                  const Padding(padding: EdgeInsets.only(bottom: 100)),
                ],
              ),
            )
          ],
        ), //botão flutuante sobre a barra inferior

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Menu()),
            );
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
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.black,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PerfilAluno()),
                  );
                },
                icon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 252, 72, 27),
                  size: 35,
                ),
              ),
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.exit_to_app,
                  color: Color.fromARGB(255, 252, 72, 27),
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
