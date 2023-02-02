import 'package:flutter/material.dart';
import 'package:flutter_project_seth/backEnd/controladora/CtrlAluno.dart';

import '../../backEnd/controladora/CtrlProfessor.dart';
import '../geral/loginPage.dart';
import '../widgets/utilClass.dart';

class ForceProgress extends StatefulWidget {
  const ForceProgress({Key? key}) : super(key: key);
  @override
  State<ForceProgress> createState() => _ForceProgressState();
}

class _ForceProgressState extends State<ForceProgress> {
  TextEditingController txtUsuario = TextEditingController();
  TextEditingController txtQtdeAulas = TextEditingController();

  List<String> faixas = ["Branca", "Azul", "Roxa", "Marrom", "Preta"];
  List<String> graus = ["0", "1", "2", "3", "4"];
  String? faixaSelecionada;
  String? grauSelecionado;

  final _formKey = GlobalKey<FormState>();

  void dropDownFaixaSelected(String novoItem) {
    setState(() {
      faixaSelecionada = novoItem;
    });
  }

  void dropDownGrauSelected(String novoItem) {
    setState(() {
      grauSelecionado = novoItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Detecta a ára fora dos campos
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          //Foco no campo primario
          //Desfocar
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            //Barra superior já com o icone de voltar
            backgroundColor: const Color.fromARGB(255, 252, 72, 27),

            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("        Forçar Progresso"),
              ],
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

          //drawer para navegação no appbar
          //A classe Drawer está sendo chamada de outro arquivo e está recebendo por parametro o texto desejado.
          endDrawer: const Drawer(
            child: DrawerTop(
              texto: "Opções",
            ),
          ),
          body: Stack(alignment: Alignment.center, children: <Widget>[
            Container(),
            //Posicionamento do campo ao selecionar o campo
            SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Insira os dados abaixo:",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 26)),

                  const Padding(padding: EdgeInsets.only(top: 20)),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 325,
                          child: TextFormField(
                            controller: txtUsuario,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 252, 72, 27),
                              ),
                              labelText: "Usuário",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 72, 27))),
                            ),
                            validator: (value) {
                              return validaUsuario(txtUsuario.text);
                            },
                          ),
                        ),

                        //Espaçamento entre inputs
                        const Padding(padding: EdgeInsets.only(top: 15)),

                        SizedBox(
                          width: 325,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.upgrade,
                                color: Color.fromARGB(255, 252, 72, 27),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 17)),
                              const Text(
                                "Selecione a Faixa:",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 107, 107, 107)),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 20),
                              ),
                              DropdownButton<String>(
                                underline: Container(
                                  height: 2,
                                  color: const Color.fromARGB(255, 252, 72, 27),
                                ),
                                value: faixaSelecionada,
                                items: faixas.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    faixaSelecionada = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        //Espaçamento entre inputs
                        const Padding(padding: EdgeInsets.only(top: 15)),

                        SizedBox(
                          width: 325,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.upgrade,
                                color: Color.fromARGB(255, 252, 72, 27),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 17)),
                              const Text(
                                "Selecione o grau da faixa:",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 107, 107, 107)),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 20),
                              ),
                              DropdownButton<String>(
                                underline: Container(
                                  height: 2,
                                  color: const Color.fromARGB(255, 252, 72, 27),
                                ),
                                value: grauSelecionado,
                                items: graus.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    grauSelecionado = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Espaçamento entre os campos e o botão cadastrar
                  const Padding(padding: EdgeInsets.only(top: 300)),

                  //Botão cadastrar
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          forcaProgresso(txtUsuario.text, faixaSelecionada!,
                              grauSelecionado!);
                          loading();
                          //cadAluno(txtUsuario.text);
                          closeLoading();
                          Navigator.pop(context, false);
                          alertUser();
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                        fixedSize: const Size(330, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ), //texto do button e estilo da escrita
                      child: const Text(
                        "Enviar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ],
              ),
            )
          ])),
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

  alertUser() {
    String name = txtUsuario.text;
    showDialog<String>(
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Progresso alterado!'),
        content: Text('A alteração do progresso do aluno $name foi realizada.'),
        actions: <Widget>[
          TextButton(
            //Se for selecionado Não
            onPressed: () => Navigator.pop(context, 'Ok'),
            child: const Text('Ok'),
          ),
        ],
      ),
      context: context,
    );
  }
}
