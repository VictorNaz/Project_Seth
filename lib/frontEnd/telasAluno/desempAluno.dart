import 'package:flutter/material.dart';

import '../widgets/utilClass.dart';
import 'MenuPrincipal.dart';

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
        title: const Text("Meu Desempenho"),

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
              children: const [
                // Esta classe retorna um card com um expansionTile dentro, recebendo o titulo e a descrição do mesmo.
                CardDropButton(
                    titulo: "Meu Progresso",
                    descricao:
                        "No momento não tenho nenhum texto para apresentar para você, dito isso não sei por que continuar lendo isso... Respiração Automática desligada!!!"),

                //Espaçamento entre botões
                Padding(padding: EdgeInsets.only(bottom: 40)),

                // Esta classe retorna um card com um expansionTile dentro, recebendo o titulo e a descrição do mesmo.
                CardDropButton(
                    titulo: "Aulas Fundamentais",
                    descricao:
                        "No momento não tenho nenhum texto para apresentar para você, dito isso não sei por que continua lendo isso... Respiração Automática desligada!!!"),

                //Espaçamento entre botões
                Padding(padding: EdgeInsets.only(bottom: 40)),

                // Esta classe retorna um card com um expansionTile dentro, recebendo o titulo e a descrição do mesmo.
                CardDropButton(
                    titulo: "Auto Avaliação",
                    descricao:
                        "No momento não tenho nenhum texto para apresentar para você, dito isso não sei por que continua lendo isso... Respiração Automática desligada!!!"),

                //Espaçamento entre botão e o final da tela
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
