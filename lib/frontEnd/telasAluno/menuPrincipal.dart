import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/telasAluno/AutoAvaliacao.dart';
import 'package:flutter_project_seth/frontEnd/telasAluno/info.dart';

import '../widgets/utilClass.dart';
import 'desempAluno.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              children: const [
                //A classe BotaoMenu é uma classe auxiliar que recebe o texto e o icone para
                //retornar o botao completo
                BotaoMenu(
                  texto: "Auto Avaliação",
                  icone: Icon(
                    Icons.text_increase,
                    size: 50,
                    color: Colors.black,
                  ),
                  tela: AutoAvaliacao(),
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
                  tela: Info(),
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
      bottomNavigationBar: const BotaoInferior(),
    );
  }
}