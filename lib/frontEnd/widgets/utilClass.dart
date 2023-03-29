// ignore_for_file: must_be_immutable, file_names

import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_seth/backEnd/controladora/CtrlAluno.dart';
import 'package:flutter_project_seth/backEnd/modelo/faixa.dart';
import 'package:flutter_project_seth/backEnd/security/sessionService.dart';
import 'package:flutter_project_seth/frontEnd/geral/Homepage.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_project_seth/frontEnd/widgets/APIServiceProvider.dart';
import 'package:path/path.dart';
import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/server/serverAluno.dart';
import '../telasAluno/PerfilAluno.dart';

//classe que retorna o drawertop
class DrawerTop extends StatefulWidget {
  final String texto;
  final String nome;
  final String email;

  const DrawerTop(
      {super.key,
      required this.texto,
      required this.nome,
      required this.email});

  @override
  // ignore: no_logic_in_create_state
  State<DrawerTop> createState() => _DrawerTopState(texto, nome, email);
}

class _DrawerTopState extends State<DrawerTop> {
  _DrawerTopState(this.texto, this.nome, this.email);
  final String texto;
  final String nome;
  final String email;
  String? faixa = "...";
  String? grau = "...";
  String? nivel;
  var aluno = Aluno();
  var faixaInfo = Faixa();

  getInfo<Aluno>() async {
    aluno.usuario = await PrefsService.returnUser();
    await ServerAluno.buscaInfo(aluno).then((value) {
      setState(() {
        aluno = value;
        aluno.nivel_acess = nivel;
      });
    });
  }

  //Obtem a faixa e o grau do aluno
  getFaixa<String>() async {
    var aluno = Aluno();
    aluno.usuario = await PrefsService.returnUser();
    aluno = await buscaInfo(aluno);
    await buscaFaixa(aluno).then((value) {
      setState(() {
        faixaInfo = value;
        faixa = value.faixa;
        grau = value.grau;
      });
    });
  }

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    getFaixa();
    getInfo();
    super.initState();
  }

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
        UserAccountsDrawerHeader(
          currentAccountPictureSize: const Size.square(70.0),
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 12.0, color: Color.fromARGB(255, 252, 72, 27))),
            color: Color.fromARGB(0, 255, 255, 255),
          ),
          accountName: Text(nome, style: const TextStyle(color: Colors.black)),
          accountEmail: Text(email,
              style: const TextStyle(
                color: Colors.black,
              )),
          currentAccountPicture: const CircleAvatar(
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
              if (aluno.nome == 'Administrador') {
                print(aluno.usuario);
                //Passada as informações do aluno e de sua faixa
                NotificationService(aluno, faixaInfo);
              } else {
                print("nivel");
                print(aluno.usuario);
                null;
              }
            }),
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
          onTap: () async {
            const path = 'assets/image/Regras_Tatame.pdf';
            final files = await PDFApi.loadAsset(path);
            openPDF(context, files);
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

  static void openPDF(BuildContext context, File file) =>
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PDFViewerPage(
                  file: file,
                  titulo: 'Regras do Tatame',
                )),
      );
}

//classe que retorna o botão configurado
class BotaoMenu extends StatelessWidget {
  const BotaoMenu({
    Key? key,
    required this.texto,
    required this.icone,
    required this.tela,
  }) : super(key: key);

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
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => exit(0)),
                            (Route<dynamic> route) => false);
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

//Visualização dos PDF´s
class PDFViewerPage extends StatefulWidget {
  final File? file;
  final String titulo;

  const PDFViewerPage({
    Key? key,
    required this.file,
    required this.titulo,
  }) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

//Gera a página que exibirá os PDF´s
class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;

  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file!.path);
    final text = '${indexPage + 1} de $pages';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: Text(widget.titulo),
        actions: pages >= 2
            ? [
                Center(child: Text(text)),
                IconButton(
                  icon: const Icon(Icons.chevron_left, size: 32),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller.setPage(page);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, size: 32),
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    controller.setPage(page);
                  },
                ),
              ]
            : null,
      ),
      body: PDFView(
        filePath: widget.file!.path,
        // autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        // pageFling: false,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
    );
  }
}

NotificationService(Aluno aluno, Faixa faixa) {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'Basic',
          channelName: 'Progresso Alcançado!',
          channelDescription: 'Mensagem Seth',
          importance: NotificationImportance.Max)
    ],
    debug: true,
  );
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  //Verifica se o Grau da faixa é liso para alterar o texto
  String corpoMsg;
  if (faixa.grau == '0') {
    corpoMsg = '${aluno.nome} agora está no Grau liso da faixa ${faixa.faixa}!';
  } else {
    corpoMsg =
        '${aluno.nome} agora está no ${faixa.grau}º Grau da faixa ${faixa.faixa}!';
  }
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          icon: Emojis.body_tongue,
          channelKey: 'Basic',
          title: "Novo progresso de aluno!",
          body: corpoMsg,
          criticalAlert: true));
}
