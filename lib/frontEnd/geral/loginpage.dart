import 'package:flutter/material.dart';
import 'package:flutter_project_seth/backEnd/controladora/CtrlAluno.dart';
import 'package:flutter_project_seth/frontEnd/telasMestre/MenuMestre.dart';
import 'package:flutter_project_seth/frontEnd/widgets/splashScreen.dart';

import '../telasAluno/CadAluno.dart';
import '../telasAluno/MenuPrincipal.dart';
import '../telasProf/MenuProfessor.dart';
import 'RecSenha.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;
  bool isChecked = false;
  String nivel_acess = "";

  TextEditingController txtUsuario = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Detecta a ára fora dos campos
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          //Foco primario
          //Desfocar
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          //Barra superior já com o icone de voltar
          backgroundColor: const Color.fromARGB(255, 252, 72, 27),
          title: const Text("Página de Login"),

          //Icone de voltar quando utilizado o drawer no appbar
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context, false)),
        ),

        //Corpo já centralizado
        body: Stack(alignment: Alignment.center, children: <Widget>[
          Container(),
          SingleChildScrollView(
            //Subir o texto ao selecionar os inputs
            child: Column(
              children: [
                //Corpo superior, Icone e mensagem de bem vindo
                const Padding(padding: EdgeInsets.only(top: 20)),
                Image.asset(
                  'assets/image/logomarca.png',
                  height: 200,
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                const Text("Seja bem-vindo!",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                const Text("Insira as suas informações para entrar.",
                    style: TextStyle(color: Colors.grey, fontSize: 16)),

                //Espaçamento entre o corpo superior e os inputs
                const Padding(padding: EdgeInsets.only(top: 40)),

                Form(
                    key: _formKey,
                    child: Column(children: [
                      //Campo email
                      SizedBox(
                        width: 325,
                        child: TextFormField(
                          controller: txtUsuario,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person_outline,
                                color: Color.fromARGB(255, 252, 72, 27),
                                size: 35),
                            labelText: "Usuario de Acesso",
                            hintStyle: TextStyle(color: Colors.black),
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

                      //Campo Senha
                      SizedBox(
                        width: 325,
                        child: TextFormField(
                          controller: txtSenha,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.lock_outline,
                              color: Color.fromARGB(255, 252, 72, 27),
                              size: 35,
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
                            return validaSenhaLogin(txtSenha.text);
                          },
                          obscureText: showPassword == false ? true : false,
                        ),
                      ),
                    ])),

                //Espaçamento entre o campo senha e o button entrar
                const Padding(padding: EdgeInsets.only(top: 100)),

                //Botão entrar
                TextButton(
                    onPressed: () async {
                      //Abre a splashscreen

                      if (_formKey.currentState!.validate()) {
                        loading();
                        nivel_acess = (await loginUsuario(
                            txtUsuario.text, txtSenha.text))!;

                        if (nivel_acess == "1") {
                          //Remove as abas acessadas anteriormente, limpa a memória
                          //Impedindo que o usuário volte para a tela de login
                          closeLoading();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Menu()),
                              (Route<dynamic> route) => false);
                        } else if (nivel_acess == "2") {
                          closeLoading();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const MenuProfessor()),
                              (Route<dynamic> route) => false);
                        } else if (nivel_acess == "3") {
                          closeLoading();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const MenuMestre()),
                              (Route<dynamic> route) => false);
                        } else {
                          closeLoading();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              (Route<dynamic> route) => false);
                          alertUser();
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
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                //espaçamento entre o button entrar em o Recuperar senha
                const Padding(padding: EdgeInsets.only(top: 20)),

                //Campo Recuperar senha
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RecSenha()),
                      );
                    },
                    style: TextButton.styleFrom(
                      fixedSize: const Size(330, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ), //texto do button e estilo da escrita
                    child: const Text(
                      "Recuperar senha",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    )),

                //Campo cadastrar-se
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CadAluno()),
                      );
                    },
                    style: TextButton.styleFrom(
                      fixedSize: const Size(330, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ), //texto do button e estilo da escrita
                    child: const Text(
                      "Cadastrar-se",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }

//Tela de carregamento pré-login
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

  //Informa erro de usuário e senha
  alertUser() {
    showDialog<String>(
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Falha ao realizar login'),
        content: const Text('Usuário ou senha inválidos'),
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
