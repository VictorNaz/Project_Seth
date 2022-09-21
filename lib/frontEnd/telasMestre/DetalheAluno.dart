import 'package:flutter/material.dart';

class DetalheAluno extends StatelessWidget{
  final int index;

  DetalheAluno(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina de detalhes do aluno'),
      ),
        body: Center(
          child: Text('Detalhes do aluno $index'),
      ),
   );
  }
}