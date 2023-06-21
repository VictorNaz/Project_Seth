import 'package:flutter/material.dart';

import '../../backEnd/controladora/CtrlProfessor.dart';
import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../widgets/utilClass.dart';

class ListaAlunoPresenca extends StatefulWidget {
  const ListaAlunoPresenca({Key? key}) : super(key: key);

  @override
  State<ListaAlunoPresenca> createState() => _ListaAlunoPresencaState();
}

class _ListaAlunoPresencaState extends State<ListaAlunoPresenca> {
  List listaAlunos = [];
  String teste = "";

  String nome = "";
  String email = "";
  var aluno = Aluno();
  bool showPassword = true;
  TextEditingController txtSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          child: Text("Validação de Presença"),
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
              title: Text('${listaAlunos[index].nome}'),
              subtitle: Text('Usuário: ${listaAlunos[index].usuario}'),
              leading: const Icon(Icons.person),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  validaPresenca('${listaAlunos[index].nome}',
                      '${listaAlunos[index].usuario}');
                  print(listaAlunos[index]);
                },
              ),
            ));
          },
          padding: const EdgeInsets.all(10),
          separatorBuilder: (context, index) => const Divider(),
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

  validaPresenca(String nomeAluno, String usuarioAluno) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Text('Aluno: $nomeAluno'),
                content: const Text(
                    'Para contabilizar a sua presença, é necessário inserir abaixo a sua senha de acesso!'),
                actions: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: txtSenha,
                          keyboardType: TextInputType.visiblePassword,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            fillColor: Colors.black,
                            hintStyle: const TextStyle(color: Colors.black),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 252, 72, 27))),
                            suffixIcon: GestureDetector(
                              child: Icon(
                                showPassword == false
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            return validarSenha(txtSenha.text);
                          },
                          obscureText: showPassword == false ? true : false,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 15)),
                      TextButton(
                        //Se for selecionado Não
                        onPressed: () => Navigator.pop(context, 'Não'),
                        child: const Text('Não'),
                        
                      ),
                      TextButton(
                        //Se for selecionado sim
                        onPressed: () async {
                          String senha = txtSenha.text;
                          String retorno =
                              await validaPresencaSenha(usuarioAluno, senha);
                          exibeAviso(retorno);
                        },
                        child: const Text('Sim'),
                      ),
                    ]),
                  ),
                ]));
  }

  exibeAviso(String conteudo) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Validação de Presença"),
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
