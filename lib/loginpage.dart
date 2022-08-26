import 'package:flutter/material.dart';
import 'package:flutter_project_seth/cadAluno.dart';
import 'package:flutter_project_seth/menuPrincipal.dart';
import 'package:flutter_project_seth/recSenha.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool showPassword = false;

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
          actions: const [],
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

                //Campo email
                SizedBox(
                  width: 325,
                  child: TextFormField(
                    //foca no primeiro campo ao entrar na página
                    autofocus: true,

                    //Define o teclado para digitar e-mail(adiciona o @ no teclado)
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person_outline,
                          color: Color.fromARGB(255, 252, 72, 27), size: 35),
                      labelText: "Email",
                      hintStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 252, 72, 27))),
                    ),
                  ),
                ),

                //Espaçamento entre inputs
                const Padding(padding: EdgeInsets.only(top: 15)),
                
                //Campo Senha
                SizedBox(
                  width: 325,
                  child: TextFormField(
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
                        child: Icon(showPassword == false ? Icons.visibility_off : Icons.visibility, color: Colors.black,),
                        onTap: (){
                          setState(() {
                            showPassword =! showPassword;
                          });
                        },
                      ),
                    ),
                    obscureText: showPassword == false ? true : false,
                    ),
    
                ),
                

                //Espaçamento entre o campo senha e o button entrar
                const Padding(padding: EdgeInsets.only(top: 100)),

                //Botão entrar
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Menu()),
                      );
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
}
