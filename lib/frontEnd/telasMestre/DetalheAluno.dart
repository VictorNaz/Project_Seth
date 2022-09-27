import 'package:flutter/material.dart';

import '../widgets/utilClass.dart';

class DetalheAluno extends StatelessWidget{
  final int index;

  DetalheAluno(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: Text('Detalhes do aluno'),

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

      body: Center(
          child: Text('Detalhes do aluno $index'),
      ),
      
   );
  }
}