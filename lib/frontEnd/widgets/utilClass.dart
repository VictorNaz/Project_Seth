import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_seth/backEnd/security/sessionService.dart';
import 'package:flutter_project_seth/frontEnd/geral/Homepage.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_project_seth/frontEnd/widgets/APIServiceProvider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
          onTap: () async {
            final path = 'assets/image/Regras_Tatame.pdf';
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
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file, titulo: 'Regras do Tatame',)),
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

  const PDFViewerPage(
     {
    Key? key,
    required this.file, required this.titulo,
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

/*class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;
  final path = 'assets/image/Info.pdf';
   final File? files = null;                       



  @override
  Widget build(BuildContext context) {

                       
    final text = '${indexPage + 1} de $pages';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Text("Regras do Tatame"),
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
      
      body: PDFView (
      
        filePath: widget.file.path,
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

  closeLoading() {
    Navigator.pop(context as BuildContext);
  }

  Future<Widget> loadAsset() async {
    final path = 'assets/image/Info.pdf';

    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();

    final filename = basename(path);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return PDFViewerPage(file: file);
  }
}*/
