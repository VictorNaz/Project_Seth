import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/telasAluno/info.dart';
import 'package:flutter_project_seth/frontEnd/telasMestre/ForceProgress.dart';
import 'package:flutter_project_seth/frontEnd/telasMestre/ListaAluno.dart';
import 'package:flutter_project_seth/frontEnd/telasMestre/Relatorio.dart';
import 'package:flutter_project_seth/frontEnd/widgets/QR_CodePage.dart';
import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../telasProf/ValPresenca.dart';
import '../widgets/utilClass.dart';
import 'CadProfessor.dart';

class MenuMestre extends StatefulWidget {
  const MenuMestre({Key? key}) : super(key: key);

  @override
  State<MenuMestre> createState() => _MenuMestreState();
}

class _MenuMestreState extends State<MenuMestre> {
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
        title: const Center(
          child: Text("       Menu Mestre"),
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
      endDrawer:  Drawer(
        child: DrawerTop(
          texto: "Opções", nome: nome,
          email: email,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    BotaoMenu(
                        texto: "Cadastrar Professor",
                        icone: Icon(
                          Icons.group_add_outlined,
                          size: 80,
                          color: Color.fromARGB(255, 252, 72, 27),
                        ),
                        tela: CadProfessor()),
                    Padding(padding: EdgeInsets.only(right: 30)),
                    BotaoMenu(
                        texto: "Validar Presença",
                        icone: Icon(
                          Icons.fact_check_outlined,
                          size: 80,
                          color: Color.fromARGB(255, 252, 72, 27),
                        ),
                        tela: QRCodeMake()),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    BotaoMenu(
                        texto: "Desempenho \n Alunos",
                        icone: Icon(
                          Icons.add_chart_rounded,
                          size: 80,
                          color: Color.fromARGB(255, 252, 72, 27),
                        ),
                        tela: ListaAluno()),
                    Padding(padding: EdgeInsets.only(right: 30)),
                    BotaoMenu(
                        texto: "Relatórios",
                        icone: Icon(
                          Icons.grading_sharp,
                          size: 80,
                          color: Color.fromARGB(255, 252, 72, 27),
                        ),
                        tela: Relatorio()),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                const BotaoMenu(
                    texto: "Forçar Progresso",
                    icone: Icon(
                      Icons.build,
                      size: 80,
                      color: Color.fromARGB(255, 252, 72, 27),
                    ),
                    tela: ForceProgress()),
                const Padding(padding: EdgeInsets.only(bottom: 80)),
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
            MaterialPageRoute(builder: (context) => const MenuMestre()),
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
      bottomNavigationBar: const BotaoInferior(),
    );
  }
}
