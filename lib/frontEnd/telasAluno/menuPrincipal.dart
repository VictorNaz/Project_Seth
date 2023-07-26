import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_seth/frontEnd/telasAluno/Auto_Avaliacao.dart';
import 'package:flutter_project_seth/frontEnd/telasAluno/info.dart';
import 'package:flutter_project_seth/frontEnd/widgets/QR_CodePage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../widgets/APIServiceProvider.dart';
import '../widgets/utilClass.dart';
import 'desempAluno.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
      extendBody: true,
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Center(
          child: Text(
            "      Menu",
            style: TextStyle(fontSize: 25),
          ),
        ),
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
                    //A classe BotaoMenu é uma classe auxiliar que recebe o texto e o icone para
                    //retornar o botao completo
                    BotaoMenu(
                      texto: "Auto Avaliação",
                      icone: Icon(
                        Icons.text_increase,
                        size: 80,
                        color: Color.fromARGB(255, 252, 72, 27),
                      ),
                      tela: Auto_Avaliacao(),
                    ),

                    Padding(padding: EdgeInsets.only(right: 30)),

                    BotaoMenu(
                      texto: "Meu Desempenho",
                      icone: Icon(
                        Icons.add_chart_rounded,
                        size: 80,
                        color: Color.fromARGB(255, 252, 72, 27),
                      ),
                      tela: DesempAluno(),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BotaoMenu(
                      texto: "Validar Presença",
                      icone: Icon(
                        Icons.fact_check_outlined,
                        size: 80,
                        color: Color.fromARGB(255, 252, 72, 27),
                      ),
                      tela: QRCodeRead(),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 30)),
                    ElevatedButton(
                      onPressed: () async {
                        final path = 'assets/image/info.pdf';
                        final files = await PDFApi.loadAsset(path);
                        // ignore: use_build_context_synchronously
                        openPDF(context, files);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 248, 248, 248),
                        fixedSize: const Size(165, 150),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 15,
                        shadowColor: const Color.fromARGB(255, 252, 72, 27),
                      ),
                      child: Column(
                        children: const [
                          Padding(padding: EdgeInsets.only(top: 8)),
                          Icon(
                            Icons.info_outline_rounded,
                            size: 80,
                            color: Color.fromARGB(255, 252, 72, 27),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 4)),
                          Text(
                            "Informações",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 300)),
              ],
            ),
          ),
        ],
      ),

      //botão flutuante sobre a barra inferior

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pop(context, false);
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

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PDFViewerPage(
                  file: file,
                  titulo: 'Informações',
                )),
      );
}
