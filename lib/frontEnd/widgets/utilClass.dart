import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_seth/backEnd/security/sessionService.dart';
import 'package:flutter_project_seth/frontEnd/geral/Homepage.dart';

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
        SizedBox(
          height: 64,
          child: DrawerHeader(
            padding: const EdgeInsets.only(right: 30),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 252, 72, 27),
            ),
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  // alignment: Alignment.bottomRight,
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 255, 255, 255),
                    size: 30,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Text(
                  texto,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),

        //Parte do Drawer que vai conter as informações do usuário
        const UserAccountsDrawerHeader(
          currentAccountPictureSize: Size.square(70.0),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 12.0, color: Color.fromARGB(255, 252, 72, 27))),
            color: Color.fromARGB(0, 255, 255, 255),
          ),
          accountName:
              Text("Teste Usuário", style: TextStyle(color: Colors.black)),
          accountEmail: Text("teste@gmail.com",
              style: TextStyle(
                color: Colors.black,
              )),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/image/marciano.jpg'),
          ),
        ),
        ListTile(
          title: Container(
              padding: const EdgeInsets.only(top: 5),
              color: const Color.fromARGB(255, 228, 227, 227),
              height: 50,
              child: Row(
                children: const [
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 32,
                  ),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  Text(
                    'Notificações',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Container(
              padding: const EdgeInsets.only(top: 5),
              color: const Color.fromARGB(255, 228, 227, 227),
              height: 50,
              child: Row(
                children: const [
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Icon(
                    Icons.list,
                    color: Colors.black,
                    size: 32,
                  ),
                  Padding(padding: EdgeInsets.only(right: 27)),
                  Text(
                    'Termos de Uso',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Container(
              padding: const EdgeInsets.only(top: 5),
              color: const Color.fromARGB(255, 228, 227, 227),
              height: 50,
              child: Row(
                children: const [
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Icon(
                    Icons.checklist_rtl,
                    color: Colors.black,
                    size: 32,
                  ),
                  Padding(padding: EdgeInsets.only(right: 12)),
                  Text(
                    'Regras do Tatame',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Container(
              padding: const EdgeInsets.only(top: 5),
              color: const Color.fromARGB(255, 228, 227, 227),
              height: 50,
              child: Row(
                children: const [
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Icon(
                    Icons.info,
                    color: Colors.black,
                    size: 32,
                  ),
                  Padding(padding: EdgeInsets.only(right: 62)),
                  Text(
                    'Sobre',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Container(
              padding: const EdgeInsets.only(top: 5),
              color: const Color.fromARGB(255, 228, 227, 227),
              height: 50,
              child: Row(
                children: const [
                  Padding(padding: EdgeInsets.only(left: 20)),
                  Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 32,
                  ),
                  Padding(padding: EdgeInsets.only(right: 12)),
                  Text(
                    'Encerrar Sessão',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )),
          onTap: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Deseja Sair da Sessão?'),
                content: const Text('Esta sessão será encerrada'),
                actions: <Widget>[
                  TextButton(
                    //Se for selecionado Não
                    onPressed: () => Navigator.pop(context, 'Não'),
                    child: const Text('Não'),
                  ),
                  TextButton(
                    //Se for selecionado sim
                    onPressed: () {
                      PrefsService.logout;
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text('Sim'),
                  ),
                ],
              ),
            );
          },
        ),
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
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        fixedSize: const Size(165, 150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 15,
        shadowColor: const Color.fromARGB(255, 252, 72, 27),
      ),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 8)),
          icone,
          const Padding(padding: EdgeInsets.only(bottom: 4)),
          Text(
            texto,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

//Configuração do botão inferior, appbar
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
              color: Color.fromARGB(255, 255, 255, 255),
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () {
              //As instruções abaixo criam a caixa de diálogo
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Deseja Realmente Sair?'),
                  content: const Text('O aplicativo será encerrado'),
                  actions: <Widget>[
                    TextButton(
                      //Se for selecionado Não
                      onPressed: () => Navigator.pop(context, 'Não'),
                      child: const Text('Não'),
                    ),
                    TextButton(
                      //Se for selecionado sim
                      onPressed: () {
                        PrefsService.logout;
                        exit(0);
                      },
                      child: const Text('Sim'),
                    ),
                  ],
                ),
              );

              //Encerra a sessão
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}

//Seleção das notas da auto-avaliação
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
