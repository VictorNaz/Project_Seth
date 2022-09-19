import 'package:flutter/material.dart';
import '../telasAluno/desempAluno.dart';
import '../widgets/utilClass.dart';
import 'ValPresenca.dart';

class MenuProfessor extends StatefulWidget {
  const MenuProfessor({Key? key}) : super(key: key);

  @override
  State<MenuProfessor> createState() => _MenuProfessorState();
}

class _MenuProfessorState extends State<MenuProfessor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Text("Menu Professor"),

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
                //A classe BotaoMenu é uma classe auxiliar que recebe o texto e o icone para retornar
                //o botao completo
                BotaoMenu(
                    texto: "Validar Presença",
                    icone: Icon(
                      Icons.fact_check_outlined,
                      size: 50,
                      color: Colors.black,
                    ),
                    tela: ValPresenca()),
                Padding(padding: EdgeInsets.only(top: 40)),
                BotaoMenu(
                    texto: "Desempenho dos \n Alunos",
                    icone: Icon(
                      Icons.add_chart_rounded,
                      size: 50,
                      color: Colors.black,
                    ),
                    tela: DesempAluno()),
                Padding(padding: EdgeInsets.only(top: 40)),
                BotaoMenu(
                    texto: "Informações",
                    icone: Icon(
                      Icons.info_outline_rounded,
                      size: 50,
                      color: Colors.black,
                    ),
                    tela: MenuProfessor()),
                Padding(padding: EdgeInsets.only(bottom: 140)),
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
            MaterialPageRoute(builder: (context) => const MenuProfessor()),
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
          children: const [
            IconButton(
              onPressed: (null),
              icon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 252, 72, 27),
                size: 35,
              ),
            ),
            IconButton(
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
