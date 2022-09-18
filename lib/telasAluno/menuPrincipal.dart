import 'package:flutter/material.dart';
import 'package:flutter_project_seth/telasAluno/desempAluno.dart';
import 'package:flutter_project_seth/widgets/utilClass.dart';

import 'PerfilAluno.dart';

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
      //corpo
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            //imagem de backgroud.
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/fundo5.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          //Posicionamento do campo ao selecionar o campo
          SingleChildScrollView(
            child: Column(
<<<<<<< HEAD
              children: const [
                //A classe BotaoMenu é uma classe auxiliar que recebe o texto e o icone para retornar o botao completo
                BotaoMenu(
=======
              children: [
                //botao autoavaliação
                const BotaoMenu(
>>>>>>> 59f180a8e1cd1e7192fad02a2e3ff134f283aaf0
                  texto: "Auto Avaliação",
                  icone: Icon(
                    Icons.text_increase,
                    size: 50,
                    color: Colors.black,
<<<<<<< HEAD
=======
                  ),
                ),

                ElevatedButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                    fixedSize: const Size(320, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.text_increase,
                        size: 50,
                        color: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.only(right: 40)),
                      Text(
                        "Auto Avaliação",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
>>>>>>> 59f180a8e1cd1e7192fad02a2e3ff134f283aaf0
                  ),
                  tela: Menu(),
                ),

                Padding(padding: EdgeInsets.only(top: 40)),

                BotaoMenu(
                  texto: "Meu Desempenho",
                  icone: Icon(
                    Icons.add_chart_rounded,
                    size: 50,
                    color: Colors.black,
                  ),
                  tela: DesempAluno(),
                ),

                Padding(padding: EdgeInsets.only(top: 40)),

                BotaoMenu(
                  texto: "Quadro de Aulas",
                  icone: Icon(
                    Icons.calendar_month_outlined,
                    size: 50,
                    color: Colors.black,
                  ),
                  tela: Menu(),
                ),

                Padding(padding: EdgeInsets.only(top: 40)),

                BotaoMenu(
                  texto: "Informações",
                  icone: Icon(
                    Icons.info_outline_rounded,
                    size: 50,
                    color: Colors.black,
                  ),
                  tela: Menu(),
                ),

                Padding(padding: EdgeInsets.only(bottom: 100)),
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
                Icons.exit_to_app,
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
