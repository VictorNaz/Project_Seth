import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_seth/backEnd/controladora/CtrlAluno.dart';
import 'package:flutter_project_seth/frontEnd/widgets/APIServiceProvider.dart';
import '../geral/loginPage.dart';
import '../widgets/utilClass.dart';

class CadAluno extends StatefulWidget {
  const CadAluno({Key? key}) : super(key: key);
  @override
  State<CadAluno> createState() => _CadAlunoState();
}

class _CadAlunoState extends State<CadAluno> {
  bool checkTermos = false;
  bool checkRegras = false;
  bool showPassword = false;
  bool _showPassword = false;

  TextEditingController txtNome = TextEditingController();
  TextEditingController txtUsuario = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  TextEditingController txtConfSenha = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtcpf = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
            title: const Text("Cadastro Aluno"),

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

                  const Padding(padding: EdgeInsets.only(top: 10)),

                  Form(
                      key: _formKey,
                      child: Column(children: [
                        SizedBox(
                          width: 325,
                          child: TextFormField(
                            controller: txtUsuario,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.person_outline_outlined,
                                color: Color.fromARGB(255, 252, 72, 27),
                              ),
                              labelText: "Usuário de Acesso",
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
                          child: TextFormField(
                            controller: txtNome,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 252, 72, 27),
                              ),
                              labelText: "Nome Completo",
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 72, 27))),
                            ),
                            validator: (value) {
                              return validarNome(txtNome.text);
                            },
                          ),
                        ),

                        //Espaçamento entre inputs
                        const Padding(padding: EdgeInsets.only(top: 15)),

                        SizedBox(
                          width: 325,
                          child: TextFormField(
                            controller: txtEmail,
                            //Define o teclado para digitar e-mail(adiciona o @ no teclado)
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 252, 72, 27),
                              ),
                              labelText: "Email",
                              hintStyle: TextStyle(color: Colors.black),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 72, 27))),
                            ),
                            validator: (value) {
                              return validarEmail(txtEmail.text);
                            },
                          ),
                        ),

                        //Espaçamento entre inputs
                        const Padding(padding: EdgeInsets.only(top: 15)),

                        SizedBox(
                          width: 325,
                          child: TextFormField(
                            controller: txtcpf,
                            //Define o teclado para numérico
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.document_scanner,
                                color: Color.fromARGB(255, 252, 72, 27),
                              ),
                              labelText: "CPF",
                              hintStyle: TextStyle(color: Colors.black),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 72, 27))),
                            ),
                            validator: (value) {
                              return validaCpf(txtcpf.text);
                            },
                          ),
                        ),

                        //Espaçamento entre inputs
                        const Padding(padding: EdgeInsets.only(top: 15)),

                        SizedBox(
                          width: 325,
                          child: TextFormField(
                            controller: txtSenha,
                            decoration: InputDecoration(
                              icon: const Icon(
                                Icons.lock_outline,
                                color: Color.fromARGB(255, 252, 72, 27),
                              ),
                              labelText: "Senha",
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

                        //Espaçamento entre inputs
                        const Padding(padding: EdgeInsets.only(top: 15)),

                        SizedBox(
                          width: 325,
                          child: TextFormField(
                            controller: txtConfSenha,
                            decoration: InputDecoration(
                              icon: const Icon(
                                Icons.lock_outline,
                                color: Color.fromARGB(255, 252, 72, 27),
                              ),
                              labelText: "Confirmar senha",
                              hintStyle: const TextStyle(color: Colors.black),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 72, 27))),
                              suffixIcon: GestureDetector(
                                child: Icon(
                                  _showPassword == false
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              return validarConfSenha(
                                  txtSenha.text, txtConfSenha.text);
                            },
                            obscureText: _showPassword == false ? true : false,
                          ),
                        ),
                      ])),

                  const Padding(padding: EdgeInsets.only(top: 20)),

                  //Row para as regras do tatame
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //checkbox para as regras do tatame
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: const Color.fromARGB(255, 252, 72, 27),
                        value: checkRegras,
                        onChanged: (bool? value) async {
                          final path = 'assets/image/Regras_Tatame.pdf';
                          final files = await PDFApi.loadAsset(path);
                          openPDF(context, files);
                          setState(() {
                            checkRegras = value!;
                          });
                        },
                      ),

                      //textbutton da regras do tatame
                      TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                            fixedSize: const Size(300, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ), //texto do button e estilo da escrita
                          child: const Text(
                            "Li e estou de acordo com as regras do tatame",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          )),
                    ],
                  ),
                  //Espaçamento entre os campos e o botão cadastrar
                  const Padding(padding: EdgeInsets.only(top: 30)),

                  //Botão cadastrar
                  TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (checkRegras == true) {
                            loading();
                            bool validaEmail =
                                await buscaUsuarioPorEmail(txtEmail.text);
                            bool validaUsuario =
                                await buscaUsuarioPorUsuario(txtUsuario.text);

                            if (validaEmail == true && validaUsuario == true) {
                              closeLoading();
                              alertUser("Falha ao cadastrar usuário!",
                                  "O e-mail e o nome de usuário cadastrados já estão em uso.");
                              //false = Usuário com o email NÃO encontrado, permitir criação
                            }
                            //true = Usuário com o email encontrado, não permitir criação
                            else if (validaEmail == true) {
                              closeLoading();
                              alertUser("Falha ao cadastrar usuário!",
                                  "O e-mail inserido já esta em uso.");
                              //false = Usuário com o email NÃO encontrado, permitir criação
                            } else if (validaUsuario == true) {
                              closeLoading();
                              alertUser("Falha ao cadastrar usuário!",
                                  "O nome de usuário inserido já esta em uso.");
                            } else if (validaEmail == false &&
                                validaUsuario == false) {
                              cadAluno(txtNome.text, txtUsuario.text,
                                  txtSenha.text, txtEmail.text, txtcpf.text);
                              closeLoading();
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );

                              alertUser('Usuário cadastrado com sucesso!',
                                  'Seja bem vindo ao time ${txtNome.text}!');
                            }
                          }
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
                        "Cadastrar-se",
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

  alertUser(String titulo, String corpo) {
    //String name = txtNome.text;
    showDialog<String>(
      builder: (BuildContext context) => AlertDialog(
        title: Text(titulo),
        content: Text(corpo),
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

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PDFViewerPage(
                  file: file,
                  titulo: 'Regras do Tatame',
                )),
      );
}
