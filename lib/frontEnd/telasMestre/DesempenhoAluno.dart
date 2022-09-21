import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_project_seth/frontEnd/telasMestre/DetalheAluno.dart';

import '../widgets/utilClass.dart';

class DesempenhoAluno extends StatefulWidget {
  const DesempenhoAluno({Key? key}) : super(key: key);

  @override
  State<DesempenhoAluno> createState() => _DesempenhoAlunoState();
}

class _DesempenhoAlunoState extends State<DesempenhoAluno> {
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

        body: _buildListView(context),

/*      
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index){
            return ListTile(
              title: Text('Nome $index'),
            );
          }
        ),
*/
    );
  }

      ListView _buildListView(BuildContext context) {
        return ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text('Aluno $index'),
              subtitle: const Text('Faixa roxa'),
              leading: const Icon(Icons.person),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetalheAluno(index)));
                },
              ),
            );
          },
        );
      }
}