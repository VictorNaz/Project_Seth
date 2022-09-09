import 'package:flutter/material.dart';

class BarTop {
  Widget build(BuildContext context) {
    return AppBar(
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

      //drawer para navegação no appbar
    );
  }
}

class DrawerTop {
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 252, 72, 27)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.settings),
                Padding(padding: EdgeInsets.only(right: 20)),
                Text(
                  "Opções",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
