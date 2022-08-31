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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 160, bottom: 110),
            child: Image(
              image: AssetImage('assets/image/logomarca2.png'),
              height: 300,
            ),
          ),
          /*TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageTest()),
                );
              },
              //configurações do button
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                fixedSize: const Size(350, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Páginas Professor",
                style: TextStyle(color: Colors.white, fontSize: 25),
              )),*/
          //Paddin para mover as imagens na tela.
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
    );
  }
}
