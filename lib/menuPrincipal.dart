import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        actions: const [],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(),
          //Posicionamento do campo ao selecionar o campo
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Botão autoavaliação
                    TextButton(
                        onPressed: null,
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 252, 72, 27),
                          fixedSize: const Size(160, 160),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ), //texto do button e estilo da escrita
                        child: const Text(
                          "Autoavaliação",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        )),

                    const Padding(padding: EdgeInsets.only(left: 20)),

                    TextButton(
                        onPressed: null,
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 252, 72, 27),
                          fixedSize: const Size(160, 160),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ), //texto do button e estilo da escrita
                        child: const Text(
                          "Registrar Desempenho",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: null,
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 252, 72, 27),
                          fixedSize: const Size(160, 160),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ), //texto do button e estilo da escrita
                        child: const Text(
                          "Quadro de Aulas",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    TextButton(
                        onPressed: null,
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 252, 72, 27),
                          fixedSize: const Size(160, 160),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ), //texto do button e estilo da escrita
                        child: const Text(
                          "Informações",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      //botão flutuante sobre a barra inferior

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        backgroundColor: Color.fromARGB(255, 252, 72, 27),
        elevation: 2.0,
        child: Icon(
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
          children: const [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 252, 72, 27),
                size: 35,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.settings,
                color: Color.fromARGB(255, 252, 72, 27),
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
