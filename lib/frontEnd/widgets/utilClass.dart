import 'package:flutter/material.dart';

import '../telasAluno/PerfilAluno.dart';

//classe que retorna o drawertop
class DrawerTop extends StatelessWidget {
  const DrawerTop({Key? key, required this.texto}) : super(key: key);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 252, 72, 27)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.settings),
              const Padding(padding: EdgeInsets.only(right: 20)),
              Text(
                texto,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

//classe que retorna o botão configurado

class BotaoMenu extends StatelessWidget {
  const BotaoMenu(
      {Key? key, required this.texto, required this.icone, required this.tela})
      : super(key: key);

  final String texto;
  final Icon icone;
  final Widget tela;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => tela),
        );
      },
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        fixedSize: const Size(320, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          icone,
          const Padding(padding: EdgeInsets.only(right: 40)),
          Text(
            texto,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class BotaoInferior extends StatelessWidget {
  const BotaoInferior({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
    );
  }
}

class CardDropButton extends StatelessWidget {
  const CardDropButton(
      {super.key, required this.titulo, required this.descricao});

  final String titulo;
  final String descricao;

  @override
  Widget build(BuildContext context) {
    //A classe card cria um espaço editavel que irá conter o ExpasionTile

    return Card(

        //Determinamos o raio das bordas do card
        shape: (RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),

        //determinamos a cor do card
        //color: const Color.fromARGB(255, 252, 72, 27),

        //ClopRRect serve para que o texto não ultrapasse os raios do card
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),

          //SingleChildScrollView serve para o texto quando expandido não ultrapasse o tamanho da tela
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),

            //ExpansionTile é um botão que se expande mostrando informações adicionais
            child: ExpansionTile(
              //determinamos as cores do botão quando aberto e fechado
              textColor: const Color.fromARGB(255, 252, 72, 27),
              collapsedBackgroundColor: const Color.fromARGB(255, 252, 72, 27),
              collapsedTextColor: Colors.white,
              backgroundColor: Colors.white,
              childrenPadding: const EdgeInsets.all(16),
              //titulo do botão
              title: Text(
                titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),

              //texto quando expandido
              children: [
                Text(descricao),
              ],
            ),
          ),
        ));
  }
}
