import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PageTeste.dart';
import 'loginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky); //código para desativar a barra de tarefa

    return Container(
      //imagem de backgroud.
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/image/fundo4.jpg'), fit: BoxFit.cover),
      ),
      //imagem da logo SETH.
      child: SingleChildScrollView(
        //Comando utilizado para que o texto quando ultrapasse o limite da tela cria uma barra de rolagem.
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 130, bottom: 80),
              child: Image(
                image: AssetImage('assets/image/logomarca2.png'),
                height: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              //botão de login.
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                //configurações do button
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                  fixedSize: const Size(350, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                //texto do button e estilo da escrita
                child: const Text(
                  "Entrar",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
