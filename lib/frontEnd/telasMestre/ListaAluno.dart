import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/telasMestre/DetalheAluno.dart';

import '../../backEnd/controladora/CtrlProfessor.dart';
import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../widgets/utilClass.dart';

class ListaAluno extends StatefulWidget {
  const ListaAluno({Key? key}) : super(key: key);

  @override
  State<ListaAluno> createState() => _ListaAlunoState();
}

class _ListaAlunoState extends State<ListaAluno> {
  List listaAlunos = [];
  String teste = "";

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

  getList<List>() async {
    await buscaAlunos().then((value) {
      setState(() {
        listaAlunos = value;
      });
    });
  }

  @override
  void initState() {
    getList();
    getInfoAluno();
    super.initState();
  }

  List<String> faixa = ["Branca", "Azul", "Marrom", "Preta"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Center(
          child: Text("Desempenho do Aluno"),
        ),

        //Icone de voltar quando utilizado o drawer no appbar
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context, false)),
      ),
      endDrawer: Drawer(
        child: DrawerTop(
          texto: "Opções",
          nome: nome,
          email: email,
        ),
      ),
      //body: _buildListView(context),
      body: ListView.separated(
          itemBuilder: (_, index) {
            return SizedBox(
                child: ListTile(
              tileColor: Colors.indigo[50],
              horizontalTitleGap: 20,
              title: Text('${listaAlunos[index]}'),
              //subtitle: const Text('Faixa'),
              leading: const Icon(Icons.person),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetalheAluno(
                              usuario: listaAlunos[index],
                            )),
                  );
                  print(listaAlunos[index]);
                },
              ),
            ));
          },
          padding: EdgeInsets.all(10),
          separatorBuilder: (context, index) => Divider(),
          itemCount: listaAlunos.length),

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
