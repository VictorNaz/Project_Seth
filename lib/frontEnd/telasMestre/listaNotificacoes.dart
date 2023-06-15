import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/telasMestre/DetalheAluno.dart';
import 'package:flutter_project_seth/frontEnd/telasMestre/detalhe_progresso.dart';

import '../../backEnd/controladora/CtrlProfessor.dart';
import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/modelo/notificacoes.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../widgets/utilClass.dart';

class ListaNotificacoes extends StatefulWidget {
  const ListaNotificacoes({Key? key}) : super(key: key);

  @override
  State<ListaNotificacoes> createState() => _ListaNotificacoesState();
}

class _ListaNotificacoesState extends State<ListaNotificacoes> {
  var listaNotificacoes = [];

  String teste = "";
  List grau = []; //!Armazena a informação do grau da notificação
  String nome = "";
  String email = "";
  var aluno = Aluno();

  /*getInfoAluno<Aluno>() async {
    aluno.usuario = await PrefsService.returnUser();
    await ServerAluno.buscaInfo(aluno).then((value) {
      setState(() {
        aluno = value;
        nome = aluno.nome!;
        email = aluno.email!;
      });
    });
  }*/

  getList<List>() async {
    await buscaNotificacoes().then((value) {
      setState(() {
        listaNotificacoes = value;
        print(listaNotificacoes.length);
        print("object");
      });
    });

    for (int i = 0; i < listaNotificacoes.length; i++) {
      //!Valida a descrição quando o grau é liso
      if (listaNotificacoes[i].grau == 0) {
        grau.add('Grau Liso');
      } else {
        grau.add('${listaNotificacoes[i].grau}º Grau');
      }
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Center(
          child: Text("Notificações de Progresso        "),
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
      body: ListView.separated(
          itemBuilder: (_, index) {
            return SizedBox(
                child: ListTile(
              tileColor: Colors.indigo[50],
              horizontalTitleGap: 20,
              title: Text(
                  'Tipo de Progresso: ${listaNotificacoes[index].is_Faixa}\nAluno: ${listaNotificacoes[index].nomeAluno}'),
              subtitle: Text(
                  "Faixa - ${listaNotificacoes[index].faixa} ${grau[index]}"), //${listaNotificacoes[index].grau}º Grau"),
              leading: const Icon(Icons.notification_important_outlined,
                  color: Color.fromARGB(255, 252, 72, 27)),
              onTap: () {
                if (listaNotificacoes[index].is_Faixa == 'Faixa') {
                  //!Se a notificação for de Faixa, leva ao DetalheAluno()
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetalheProgresso(
                              nome: listaNotificacoes[index].nomeAluno,
                              id: listaNotificacoes[index].idNotificacoes,
                              usuario: listaNotificacoes[index].usuarioAluno,
                              
                            )),
                  );
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Notificação de Grau!'),
                      content: const Text(
                          'A notificação por grau não é necessário aprovar.'),
                      actions: <Widget>[
                        TextButton(
                          //Se for selecionado Não
                          onPressed: () => Navigator.pop(context, 'Ok'),
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                  null;
                }
              },
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete_outline_outlined,
                ),
                onPressed: () {
                  print(listaNotificacoes[index].idNotificacoes);
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Deseja realmente excluir?'),
                      content: Text(
                          'Isto irá excluir a seguinte notificação:\nTipo de Progresso: ${listaNotificacoes[index].is_Faixa}\nAluno: ${listaNotificacoes[index].nomeAluno}'),
                      actions: <Widget>[
                        TextButton(
                          //Se for selecionado Não
                          onPressed: () => Navigator.pop(context, 'Não'),
                          style: const ButtonStyle(
                              alignment: Alignment.bottomLeft),

                          child: const Text(
                            'Não',
                          ),
                        ),
                        TextButton(
                          //Se for selecionado sim
                          onPressed: () async {
                            Navigator.pop(context, 'Sim');

                            print(listaNotificacoes[index].idNotificacoes);
                            loading();
                            bool validaExclusao =
                                await ServerAluno.excluiNotificacao(
                                    listaNotificacoes[index].idNotificacoes);
                            if (validaExclusao == true) {
                              closeLoading();
                              exibeAviso('Notificação Excluida',
                                  'A notificação selecionada foi excluida com sucesso!');
                            } else {
                              closeLoading();
                              exibeAviso('Notificação Não Excluída',
                                  'Não foi possivel excluir a notificação selecionada!');
                            }
                            //
                          },
                          child: const Text('Sim'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ));
          },
          padding: EdgeInsets.all(10),
          separatorBuilder: (context, index) => Divider(),
          itemCount: listaNotificacoes.length),

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

  loading() {
    showDialog(
        builder: (context) => Container(
              color: const Color.fromARGB(255, 252, 72, 27),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 80),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        context: context);
  }

//Fecha a tela de carregamento
  closeLoading() {
    Navigator.pop(context);
  }

  //Gera uma caixa de dialogo, com o botão "OK, apenas para avisos, titulo e corpo por parametro"
  exibeAviso(String titulo, String conteudo) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titulo),
        content: Text(conteudo),
        actions: <Widget>[
          TextButton(
            //Se for selecionado Não
            onPressed: () => Navigator.pop(context, 'Ok'),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
