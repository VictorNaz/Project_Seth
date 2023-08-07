import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../backEnd/controladora/CtrlAluno.dart';
import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../widgets/utilClass.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PerfilAluno extends StatefulWidget {
  const PerfilAluno({Key? key}) : super(key: key);
  @override
  State<PerfilAluno> createState() => _PerfilAlunoState();
}

class _PerfilAlunoState extends State<PerfilAluno> {
  bool isChecked = false;
  bool showPassword = false;

  TextEditingController edicaoSenha = TextEditingController();
  TextEditingController edicaoNome = TextEditingController();
  TextEditingController edicaoEmail = TextEditingController();
  TextEditingController edicaoCPF = TextEditingController();

  TextEditingController _controler = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String nome = "";
  String email = "";
  String cpf = "";
  String foto = "";
  String senha = "";
  var aluno = Aluno();
  //!Variaveis das imagens
  final imagePicker = ImagePicker();
  File? imageFile;
  String imgString = "";
  var imageBase64 = '';

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  //Captura image da galeria ou da câmera
  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 40,
      maxHeight: 2000,
      maxWidth: 1150,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      final bytes = imageFile!.readAsBytesSync();
      imageBase64 = base64Encode(bytes);
      //print("BYTES $imageFile");
      //imgString = Utility.base64String(imageFile!.readAsBytesSync());
      String retorno = await ServerAluno.salvaFoto(imageBase64, email);
      //print("BYTES $bytes");

      await exibeAviso(retorno);
      //Image image = imageFromBase64String(imgString);
      //Uint8List image = dataFromBase64String(imgString);
      //print(image);
      // String imgString = Utility.base64String(await imageFile!.readAsBytes());
    }
    await getInfoAluno();
  }

//4
  getInfoAluno<Aluno>() async {
    aluno.usuario = await PrefsService.returnUser();
    await ServerAluno.buscaInfo(aluno).then((value) {
      setState(() {
        aluno = value;
        nome = aluno.nome!;
        email = aluno.email!;
        cpf = aluno.cpf!;
        foto = aluno.foto!;
        senha = "Nãotrazersenhaaobk";
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
          backgroundColor: const Color.fromARGB(207, 255, 255, 255),
          child: DrawerTop(
            texto: "Opções",
            nome: nome,
            email: email,
            foto: foto,
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 30)),
            Container(),

            //Posicionamento do campo ao selecionar o campo
            SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                //Lugar onde deve adicionar a foto de perfil do usuario.

                children: <Widget>[
                  CircleAvatar(
                    radius: 87,
                    backgroundColor: Colors.grey[200],
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: foto != null
                          ? imageFromBase64String(foto).image
                          : null,
                    ),
                  ),
                  Positioned(
                    //bottom: 7,
                    //right: 6.5,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                      child: IconButton(
                        //alignment: Alignment.topRight,
                        onPressed: _showOpcoesBottomSheet,
                        icon: Icon(
                          PhosphorIcons.regular.pencilSimple,
                          color: const Color.fromARGB(255, 252, 72, 27),
                        ),
                      ),
                    ),
                  ),
                  //Espaçamento entre foto de perfil e campos de input
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: TextEditingController(text: nome),
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.person_outline_rounded,
                                  color: Color.fromARGB(255, 252, 72, 27),
                                ),
                                labelText: "Nome Completo",
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 252, 72, 27))),
                              ),
                              enabled: false,
                              validator: (value) {
                                return validarNome(nome);
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(PhosphorIcons.regular.pencilSimple),
                            color: const Color.fromARGB(255, 252, 72, 27),
                            onPressed: () {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          title: Text('Aluno: $nome'),
                                          content: const Text(
                                              'Para alterar o seu nome, basta inserir adicionar a informação ao campo abaixo:'),
                                          actions: <Widget>[
                                            Form(
                                              key: _formKey,
                                              child: Column(children: [
                                                Center(
                                                  child: TextFormField(
                                                    controller: edicaoNome,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    textAlign: TextAlign.start,
                                                    decoration:
                                                        const InputDecoration(
                                                      icon: Icon(
                                                        Icons
                                                            .person_outline_rounded,
                                                        color: Color.fromARGB(
                                                            255, 252, 72, 27),
                                                        size: 25,
                                                      ),
                                                      labelText:
                                                          "Nome Completo",
                                                      fillColor: Colors.black,
                                                      hintStyle: TextStyle(
                                                          color: Colors.black),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          252,
                                                                          72,
                                                                          27))),
                                                    ),
                                                    validator: (value) {
                                                      return validarNome(
                                                          edicaoNome.text);
                                                    },
                                                    obscureText: true,
                                                  ),
                                                ),
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15)),
                                                TextButton(
                                                  //Se for selecionado sim
                                                  onPressed: () async {
                                                    // String retorno =
                                                    //   await editaSenha(aluno);
                                                    // exibeAviso(retorno);
                                                  },
                                                  child: const Text('Confirmar',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ),
                                                TextButton(
                                                  //Se for selecionado Não
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancelar'),

                                                  child: const Text('Cancelar',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ),
                                              ]),
                                            ),
                                          ]));
                            },
                          ),
                        ],
                      )
                    ],
                  ),

                  //Espaçamento entre inputs
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        //initialValue: usuario.email,
                        controller: TextEditingController(text: email),
                        //Define o teclado para digitar e-mail(adiciona o @ no teclado)
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.email_outlined,
                            color: Color.fromARGB(255, 252, 72, 27),
                          ),
                          labelText: "Email",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 252, 72, 27))),
                        ),
                        enabled: false,
                        validator: (value) {
                          return validarEmail(email);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(PhosphorIcons.regular.pencilSimple),
                      color: const Color.fromARGB(255, 252, 72, 27),
                      onPressed: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title: Text('Aluno: $nome'),
                                    content: const Text(
                                        'Para alterar o seu E-mail, basta inserir o seu novo e-mail abaixo:'),
                                    actions: <Widget>[
                                      Form(
                                        key: _formKey,
                                        child: Column(children: [
                                          Center(
                                            child: TextFormField(
                                              controller: edicaoEmail,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              textAlign: TextAlign.start,
                                              decoration: const InputDecoration(
                                                icon: Icon(
                                                  Icons.email_outlined,
                                                  color: Color.fromARGB(
                                                      255, 252, 72, 27),
                                                  size: 25,
                                                ),
                                                labelText: "E-mail",
                                                fillColor: Colors.black,
                                                hintStyle: TextStyle(
                                                    color: Colors.black),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    252,
                                                                    72,
                                                                    27))),
                                              ),
                                              validator: (value) {
                                                return validarEmail(
                                                    edicaoEmail.text);
                                              },
                                              obscureText: true,
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 15)),
                                          TextButton(
                                            //Se for selecionado sim
                                            onPressed: () async {
                                              // String retorno =
                                              //   await editaSenha(aluno);
                                              // exibeAviso(retorno);
                                            },
                                            child: const Text('Confirmar',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          TextButton(
                                            //Se for selecionado Não
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancelar'),

                                            child: const Text('Cancelar',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                        ]),
                                      ),
                                    ]));
                      },
                    ),
                  ]),
                  //Espaçamento entre inputs
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: TextEditingController(
                            text: cpf), //Define o teclado para numérico
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.document_scanner_outlined,
                            color: Color.fromARGB(255, 252, 72, 27),
                          ),
                          labelText: "CPF",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 252, 72, 27))),
                        ),
                        enabled: false,
                      ),
                    ),
                    IconButton(
                      icon: Icon(PhosphorIcons.regular.pencilSimple),
                      color: const Color.fromARGB(255, 252, 72, 27),
                      onPressed: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title: Text('Aluno: $nome'),
                                    content: const Text(
                                        'Para alterar o seu CPF, basta inserir (Apenas os numeros) abaixo:'),
                                    actions: <Widget>[
                                      Form(
                                        key: _formKey,
                                        child: Column(children: [
                                          Center(
                                            child: TextFormField(
                                              controller: edicaoCPF,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.start,
                                              decoration: const InputDecoration(
                                                icon: Icon(
                                                  Icons
                                                      .document_scanner_outlined,
                                                  color: Color.fromARGB(
                                                      255, 252, 72, 27),
                                                  size: 25,
                                                ),
                                                labelText: "CPF",
                                                fillColor: Colors.black,
                                                hintStyle: TextStyle(
                                                    color: Colors.black),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    252,
                                                                    72,
                                                                    27))),
                                              ),
                                              validator: (value) {
                                                return validaCpf(
                                                    edicaoCPF.text);
                                              },
                                              obscureText: true,
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 15)),
                                          TextButton(
                                            //Se for selecionado sim
                                            onPressed: () async {
                                              // String retorno =
                                              //   await editaSenha(aluno);
                                              // exibeAviso(retorno);
                                            },
                                            child: const Text('Confirmar',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          TextButton(
                                            //Se for selecionado Não
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancelar'),

                                            child: const Text('Cancelar',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                        ]),
                                      ),
                                    ]));
                      },
                    ),
                  ]),

                  //Espaçamento entre inputs
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: TextEditingController(
                            text:
                                "senhanaoaobackend"), //Define o teclado para numérico
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.lock_outline,
                            color: Color.fromARGB(255, 252, 72, 27),
                          ),
                          labelText: "Senha",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 252, 72, 27))),
                        ),
                        obscureText: true,
                        enabled: false,
                      ),
                    ),
                    IconButton(
                      icon: Icon(PhosphorIcons.regular.pencilSimple),
                      color: const Color.fromARGB(255, 252, 72, 27),
                      onPressed: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title: Text('Aluno: $nome'),
                                    content: const Text(
                                        'Para alterar a sua senha, basta inserir uma nova senha abaixo:'),
                                    actions: <Widget>[
                                      Form(
                                        key: _formKey,
                                        child: Column(children: [
                                          Center(
                                            child: TextFormField(
                                              controller: edicaoSenha,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              textAlign: TextAlign.start,
                                              decoration: const InputDecoration(
                                                icon: Icon(
                                                  Icons.lock_outline,
                                                  color: Color.fromARGB(
                                                      255, 252, 72, 27),
                                                  size: 25,
                                                ),
                                                labelText: "Nova Senha",
                                                fillColor: Colors.black,
                                                hintStyle: TextStyle(
                                                    color: Colors.black),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    252,
                                                                    72,
                                                                    27))),
                                              ),
                                              validator: (value) {
                                                return validarSenha(
                                                    edicaoSenha.text);
                                              },
                                              obscureText: true,
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 15)),
                                          TextButton(
                                            //Se for selecionado sim
                                            onPressed: () async {
                                              // String retorno =
                                              //   await editaSenha(aluno);
                                              // exibeAviso(retorno);
                                            },
                                            child: const Text('Confirmar',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          TextButton(
                                            //Se for selecionado Não
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancelar'),

                                            child: const Text('Cancelar',
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                        ]),
                                      ),
                                    ]));
                      },
                    ),
                  ]),

                  const Padding(padding: EdgeInsets.only(bottom: 100)),
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

  //!Alerta do usuário
  alertUser() {
    showDialog<String>(
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Alterações realizadas!'),
        content: const Text(''),
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

  //!Exibição das opções para alteração de foto
  void _showOpcoesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.regular.image,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  // Buscar imagem da galeria
                  pick(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.regular.camera,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () async {
                  Navigator.of(context).pop();

                  // Fazer foto da câmera
                  pick(ImageSource.camera);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.regular.trash,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Remover',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  String retorno = await ServerAluno.removeFoto(email);
                  await exibeAviso(retorno);
                  // Tornar a foto null
                  setState(() {
                    foto = "";
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //!Exibe confirmação sobre a alteração da ft de perfil
  exibeAviso(String conteudo) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Atualização de Foto de Perfil"),
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

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
