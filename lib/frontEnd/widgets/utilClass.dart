import 'dart:io';

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
          IconButton(
            onPressed: () {
              exit(0);
            },
            icon: const Icon(
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

class selectNota extends StatelessWidget {
  const selectNota({super.key, required this.texto, this.onChanged});

  final String texto;
  final dynamic onChanged;

  @override
  Widget build(BuildContext context) {
    int dropdownvalue = 1;
    List<int> items = [1, 2, 3, 4, 5];

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(texto),
          DropdownButton(
            value: dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((int items) {
              return DropdownMenuItem(
                value: items,
                child: Text("$items"),
              );
            }).toList(),
            onChanged: (int? newValue) {
              dropdownvalue = newValue!;
            },
          ),
        ],
      ),
    );
  }
}
