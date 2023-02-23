import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/telasAluno/menuPrincipal.dart';

import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../widgets/utilClass.dart';

class Relatorio extends StatefulWidget {
  const Relatorio({Key? key}) : super(key: key);

  @override
  State<Relatorio> createState() => _RelatorioState();
}

class _RelatorioState extends State<Relatorio> {
    String nome = "";
  String email = "";
  var aluno = Aluno();

  getInfoAluno<Aluno>() async {
    aluno.usuario = await PrefsService.returnUser();
    await ServerAluno.buscaInfo(aluno).then((value) {
      setState(() {
        aluno = value;
        nome = aluno.nome!;
        email = aluno.email!;
      });
    });
  }

  @override
  void initState() {
    getInfoAluno();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Text("Relatório"),

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
      endDrawer:  Drawer(
        child: DrawerTop(
          texto: "Opções", nome: nome,
          email: email,
        ),
      ),
      //botão flutuante sobre a barra inferior

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, false);
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
