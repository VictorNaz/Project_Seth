// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_project_seth/backEnd/security/dataCrypt.dart';
import 'package:flutter_project_seth/frontEnd/geral/loginpage.dart';
import 'package:flutter_project_seth/frontEnd/widgets/sendEmail.dart';
import 'package:random_password_generator/random_password_generator.dart';

import '../../backEnd/controladora/CtrlAluno.dart';
import '../widgets/utilClass.dart';
import 'redefinirSenha.dart';

class RecSenha extends StatefulWidget {
  const RecSenha({Key? key}) : super(key: key);
  @override
  State<RecSenha> createState() => _RecSenhaState();
}

class _RecSenhaState extends State<RecSenha> {
  TextEditingController txtEmail = TextEditingController();
  String _text = '';
  String senhaCript = "";
  var email = Email('pedro_v_veiga@estudante.sc.senai.br', 'Charger0077');
  String mensagem =
      "Olá, Aluno,\n\nRecebemos uma solicitação para restaurar sua senha de acesso em nosso site.\n\nSe você reconhece essa ação, clique no botão abaixo para prosseguir:";

  Future<String> _sendEmail(String destinatario) async {
    final password = RandomPasswordGenerator();
    String novaSenha = password.randomPassword();
    senhaCript = dataCrypt(novaSenha);

    bool result = await email.sendMessage(
        'Olá Aluno!\n\nSegue abaixo a sua nova senha de acesso ao Aplicativo Seth JiuJitsu\n\nSua nova senha é: $novaSenha',
        destinatario,
        'APP Seth | Redefinição de Senha');

    setState(() {
      _text = result ? 'Enviado' : 'Não enviado';
    });
    return _text;
  }

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
          title: const Text("Redefinir Senha"),

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
          SingleChildScrollView(
            child: Center(
              child: Column(children: [
                //Corpo superior, Icone e mensagem de bem vindo
                const Padding(padding: EdgeInsets.only(top: 40)),
                Image.asset(
                  'assets/image/logomarca.png',
                  height: 200,
                ),

                const Padding(padding: EdgeInsets.only(top: 30)),
                const SizedBox(
                  child: Text(
                    "Para recuperar a sua senha, é necessário preencher o campo abaixo com o e-mail que está cadastrado a sua conta!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 50)),

                SizedBox(
                  width: 325,
                  child: TextFormField(
                    controller: txtEmail,
                    //Define o teclado para digitar e-mail(adiciona o @ no teclado)
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email_outlined,
                        color: Color.fromARGB(255, 252, 72, 27),
                        size: 30,
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

                const Padding(padding: EdgeInsets.only(top: 220)),

                //Botão Enviar
                TextButton(
                    onPressed: () async {
                      bool existe = await buscaUsuarioPorEmail(txtEmail.text);
                      if (existe == true) {
                        //!Se encontrar é true
                        String isChange = '';
                        String statusEmail = await _sendEmail(txtEmail.text);
                        if (statusEmail == 'Enviado') {
                          bool checkChange = await recuperaSenha(txtEmail.text,senhaCript);
                          print(checkChange);
                          if (checkChange) {
                            isChange = 'Executado';
                          } else {
                            isChange = 'Não Executado';
                          }
                        } else {
                          isChange = 'Não Executado';
                        }
                        await showDialog<String>(
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("E-mail encontrado!"),
                            content: Text(
                                "As instruções para o processo de recuperação da senha foram enviadas para o e-mail ${txtEmail.text}.\n\nStatus do Envio: $statusEmail;\nAlteração de Senha: $isChange;"),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      } else {
                        //!Se não encontrar é false
                        alertUser("E-mail não encontrado!",
                            "O e-mail inserido não está vinculado a nenhum usuário do sistema.\nFavor inserir um e-mail válido!");
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
                const Padding(padding: EdgeInsets.only(bottom: 20)),
              ]),
            ),
          )
        ]),
      ),
    );
  }

  alertUser(String titulo, String corpo) {
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
}
