import 'package:flutter/material.dart';
import 'package:flutter_project_seth/backEnd/controladora/CtrlProfessor.dart';

import '../geral/loginPage.dart';

class CadProfessor extends StatefulWidget {
  const CadProfessor({Key? key}) : super(key: key);
  @override
  State<CadProfessor> createState() => _CadProfessorState();
}

class _CadProfessorState extends State<CadProfessor> {
  bool isChecked = false;
  bool showPassword = false;
  bool _showPassword = false;

  TextEditingController txtNome = TextEditingController();
  TextEditingController txtUsuario = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  TextEditingController txtConfSenha = TextEditingController();
  TextEditingController txtTelefone = TextEditingController();
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
            title: const Text("Cadastro Professor"),

            //Icone de voltar quando utilizado o drawer no appbar
            automaticallyImplyLeading: true,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context, false)),
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

                  const Padding(padding: EdgeInsets.only(top: 10)),

                  Form(
                    key: _formKey,
                    child: Column(children: [
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
                          controller: txtUsuario,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 252, 72, 27),
                            ),
                            labelText: "Nome de Usuário",
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
                          //Define o teclado para digitar e-mail(adiciona o @ no teclado)
                          controller: txtEmail,
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
                          //Define o teclado para numérico
                          controller: txtcpf,
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
                            return validarCpf(txtcpf.text);
                          },
                        ),
                      ),

                      //Espaçamento entre inputs
                      const Padding(padding: EdgeInsets.only(top: 15)),

                      SizedBox(
                        width: 325,
                        child: TextFormField(
                          //Define o teclado para numérico
                          controller: txtTelefone,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.phone,
                              color: Color.fromARGB(255, 252, 72, 27),
                            ),
                            labelText: "Telefone",
                            hintStyle: TextStyle(color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 252, 72, 27))),
                          ),
                          validator: (value) {
                            return validarTelefone(txtTelefone.text);
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
                    ]),
                  ),

                  const Padding(padding: EdgeInsets.only(top: 20)),

                  //Row para checkbox e Termos de Uso
                  Row(
                    //Alinhamento dos itens da Row
                    mainAxisAlignment: MainAxisAlignment.center,

                    //CheckBox Termos de uso
                    children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: const Color.fromARGB(255, 252, 72, 27),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),

                      //Botão para os termos de uso
                      TextButton(
                          onPressed: null,
                          style: TextButton.styleFrom(
                            fixedSize: const Size(300, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ), //texto do button e estilo da escrita
                          child: const Text(
                            "li e estou de acordo com os Termos de Uso e Política de Privacidade.",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          )),
                    ],
                  ),

                  //Espaçamento entre os campos e o botão cadastrar
                  const Padding(padding: EdgeInsets.only(top: 30)),

                  //Botão cadastrar
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (isChecked == true) {
                            cadProfessor(
                                txtNome.text,
                                txtUsuario.text,
                                txtTelefone.text,
                                txtSenha.text,
                                txtEmail.text,
                                txtcpf.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Casdastrado com sucesso')),
                            );
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
}
