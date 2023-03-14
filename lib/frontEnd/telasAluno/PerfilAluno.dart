import 'package:flutter/material.dart';
import '../../backEnd/controladora/CtrlAluno.dart';
import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../widgets/utilClass.dart';

class PerfilAluno extends StatefulWidget {
  const PerfilAluno({Key? key}) : super(key: key);
  @override
  State<PerfilAluno> createState() => _PerfilAlunoState();
}

class _PerfilAlunoState extends State<PerfilAluno> {
  bool isChecked = false;
  bool showPassword = false;

  TextEditingController _controler = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String nome = "";
  String email = "";
  String cpf = "";

  var aluno = Aluno();

  getInfoAluno<Aluno>() async {
    aluno.usuario = await PrefsService.returnUser();
    await ServerAluno.buscaInfo(aluno).then((value) {
      setState(() {
        aluno = value;
        nome = aluno.nome!;
        email = aluno.email!;
        cpf = aluno.cpf!;
      });
    });
  }

  @override
  void initState() {
    getInfoAluno();
    super.initState();
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
        extendBody: true,
        appBar: AppBar(
          //Barra superior já com o icone de voltar
          backgroundColor: const Color.fromARGB(255, 252, 72, 27),
          title: const Center(
            child: Text("Perfil"),
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
        endDrawer: Drawer(
          child: DrawerTop(
            texto: "Opções",
            nome: nome,
            email: email,
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(),
            const Padding(padding: EdgeInsets.only(top: 30)),

            //Posicionamento do campo ao selecionar o campo
            SingleChildScrollView(
              child: Column(
                //Lugar onde deve adicionar a foto de perfil do usuario.
                children: <Widget>[
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/image/marciano.jpg'),
                    child: IconButton(
                        onPressed:
                            null, // Adicionar aqui a chamada da seleção da foto do device
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 35.0,
                        ),
                        hoverColor: Color.fromARGB(106, 8, 8, 8)),
                  ),

                  //Espaçamento entre foto de perfil e campos de input
                  const Padding(padding: EdgeInsets.only(top: 20)),

                  SizedBox(
                    width: 325,
                    child: TextFormField(
                      controller: TextEditingController(text: nome),
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
                        return validarNome(nome);
                      },
                    ),
                  ),
                  //Espaçamento entre inputs
                  const Padding(padding: EdgeInsets.only(top: 15)),

                  SizedBox(
                    width: 325,
                    child: TextFormField(
                      //initialValue: usuario.email,
                      controller: TextEditingController(text: email),
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
                        return validarEmail(email);
                      },
                    ),
                  ),

                  //Espaçamento entre inputs
                  const Padding(padding: EdgeInsets.only(top: 15)),

                  SizedBox(
                    width: 325,
                    child: TextField(
                      controller: TextEditingController(
                          text: cpf), //Define o teclado para numérico
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
                    ),
                  ),

                  const Padding(padding: EdgeInsets.only(bottom: 150)),

                  TextButton(
                      onPressed: (null
                          //alertUser();
                          ),
                      //Adicionar uma modal confirmando
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                        fixedSize: const Size(330, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ), //texto do button e estilo da escrita
                      child: const Text(
                        "Confirmar Alterações",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),

                  const Padding(padding: EdgeInsets.only(bottom: 70)),
                ],
              ),
            )
          ],
        ),
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
      ),
    );
  }

  //Alerta do usuário
  alertUser() {
    showDialog<String>(
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alterações realizadas!'),
        content: Text(''),
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
