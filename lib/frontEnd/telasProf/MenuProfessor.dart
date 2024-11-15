import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/telasAluno/info.dart';
import 'package:flutter_project_seth/frontEnd/telasMestre/listaAlunos.dart';
import 'package:flutter_project_seth/frontEnd/widgets/QR_CodePage.dart';
import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../widgets/utilClass.dart';
import 'ValPresenca.dart';

class MenuProfessor extends StatefulWidget {
  const MenuProfessor({Key? key}) : super(key: key);

  @override
  State<MenuProfessor> createState() => _MenuProfessorState();
}

class _MenuProfessorState extends State<MenuProfessor> {
  String nome = "";
  String email = "";
  var aluno = Aluno();
  String foto = "";

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
      extendBody: true,
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Center(
          child: Text("Menu Professor"),
        ),

        //Icone de voltar quando utilizado o drawer no appbar
        /*automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context, false)),*/
      ),

      //drawer para navegação no appbar
      //A classe Drawer está sendo chamada de outro arquivo e está recebendo por parametro o texto desejado.
      endDrawer: Drawer(
        backgroundColor: Color.fromARGB(207, 255, 255, 255),
        child: DrawerTop(
          texto: "Opções",
          nome: nome,
          email: email, foto: foto,
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
              children: [
                //A classe BotaoMenu é uma classe auxiliar que recebe o texto e o icone para retornar
                //o botao completo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    BotaoMenu(
                        texto: "Validar Presença",
                        icone: Icon(
                          Icons.fact_check_outlined,
                          size: 80,
                          color: Color.fromARGB(255, 252, 72, 27),
                        ),
                        tela: QRCodeMake()),
                    Padding(padding: EdgeInsets.only(right: 30)),
                    BotaoMenu(
                        texto: "Desempenho \n Alunos",
                        icone: Icon(
                          Icons.add_chart_rounded,
                          size: 80,
                          color: Color.fromARGB(255, 252, 72, 27),
                        ),
                        tela: ListaAluno()),
                  ],
                ),

                const Padding(padding: EdgeInsets.only(top: 30)),

                const BotaoMenu(
                    texto: "Informações",
                    icone: Icon(
                      Icons.info_outline_rounded,
                      size: 80,
                      color: Color.fromARGB(255, 252, 72, 27),
                    ),
                    tela: Info()),
                const Padding(padding: EdgeInsets.only(bottom: 140)),
              ],
            ),
          ),
        ],
      ),

      //botão flutuante sobre a barra inferior

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MenuProfessor()),
          );*/
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
