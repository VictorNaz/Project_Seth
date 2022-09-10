import 'package:flutter/material.dart';

import '../widgets/utilClass.dart';
import 'menuPrincipal.dart';
import 'perfilAluno.dart';

class DesempAluno extends StatefulWidget {
  const DesempAluno({Key? key}) : super(key: key);

  @override
  State<DesempAluno> createState() => _DesempAlunoState();
}

class _DesempAlunoState extends State<DesempAluno> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            //imagem de backgroud.
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/fundo1.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                ExpansionPanelList(
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return const ListTile(
                          title: Text('Progresso'),
                        );
                      },
                      body: const Text("teste drop"),
                      canTapOnHeader: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),

      //botão flutuante sobre a barra inferior

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
                  MaterialPageRoute(builder: (context) => const PerfilAluno()),
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
