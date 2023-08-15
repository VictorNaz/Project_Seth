import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/telasAluno/menuAluno.dart';
import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../telasMestre/cadastrarProfessor.dart';
import '../telasMestre/menuMestre.dart';
import '../telasMestre/listaAlunos.dart';
import '../telasProf/ValPresenca.dart';
import '../telasProf/menuProfessor.dart';
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
  String nome = "";
  String email = "";
  String foto = "";
  var aluno = Aluno();

  getInfoAluno<Aluno>() async {
    aluno.usuario = await PrefsService.returnUser();
    await ServerAluno.buscaInfo(aluno).then((value) {
      setState(() {
        aluno = value;
        nome = aluno.nome!;
        email = aluno.email!;
        foto = aluno.foto!;
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
      endDrawer: Drawer(
        backgroundColor: Color.fromARGB(207, 255, 255, 255),
        child: DrawerTop(
          texto: "Opções",
          nome: nome,
          email: email,
          foto: foto,
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Menu()),
                    );
                  },
                  child: const Text(
                    "Menu Aluno",
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
                        builder: (context) => const MenuMestre(),
                      ),
                    );
                  },
                  child: const Text(
                    "MenuMestre",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
