import 'package:flutter/material.dart';

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

class BotaoMenu extends StatelessWidget {
<<<<<<< HEAD
  const BotaoMenu(
      {Key? key, required this.texto, required this.icone, required this.tela})
=======
  const BotaoMenu({Key? key, required this.texto, required this.icone})
>>>>>>> 59f180a8e1cd1e7192fad02a2e3ff134f283aaf0
      : super(key: key);

  final String texto;
  final Icon icone;
<<<<<<< HEAD
  final Widget tela;
=======
>>>>>>> 59f180a8e1cd1e7192fad02a2e3ff134f283aaf0

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
<<<<<<< HEAD
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => tela),
        );
      },
=======
      onPressed: null,
>>>>>>> 59f180a8e1cd1e7192fad02a2e3ff134f283aaf0
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
