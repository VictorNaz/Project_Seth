import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/telasAluno/desempAluno.dart';

import '../widgets/utilClass.dart';

class ListaAluno extends StatefulWidget {
  const ListaAluno({Key? key}) : super(key: key);

  @override
  State<ListaAluno> createState() => _ListaAlunoState();
}

class _ListaAlunoState extends State<ListaAluno> {
  List<String> nome = ["victor", "pedro", "gay", "arleu"];
  List<String> faixa = ["Branca", "Azul", "Marrom", "Preta"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Text("Desempenho do Aluno"),

        //Icone de voltar quando utilizado o drawer no appbar
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context, false)),
      ),
      endDrawer: const Drawer(
        child: DrawerTop(
          texto: "Opções",
        ),
      ),
      //body: _buildListView(context),
      body: ListView.builder(
        itemCount: nome.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text('Aluno ${nome[index]}'),
            subtitle: Text('Faixa ${faixa[index]}'),
            leading: const Icon(Icons.person),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DesempAluno()));
              },
            ),
          );
        },
      ),
    );
  }
}
