import 'package:flutter/material.dart';
import '../telasMestre/CadProfessor.dart';
import '../telasMestre/MenuMestre.dart';
import '../telasMestre/DesempenhoAluno.dart';
import '../telasProf/ValPresenca.dart';
import '../telasProf/MenuProfessor.dart';
import '../widgets/utilClass.dart';

class PageTest extends StatefulWidget {
  const PageTest({Key? key}) : super(key: key);
  @override
  State<PageTest> createState() => _PageTestState();
}

/*ALERTAAAAAA*/
//Essa tela é excluisivamente para testes e deve ser excluida ou desabilitada ao final do desenvolvimento

class _PageTestState extends State<PageTest> {
  bool isChecked = false;
  bool showPassword = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Text("Tela de teste"),

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
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CadProfessor()),
                    );
                  },
                  child: const Text(
                    "CadProfessor",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MenuMestre()),
                    );
                  },
                  child: const Text(
                    "MenuMestre",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuProfessor(),
                      ),
                    );
                  },
                  child: const Text(
                    "MenuProfessor",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                  
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DesempenhoAluno(),
                      ),
                    );
                  },
                  child: const Text(
                    "DesempenhoAluno",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
