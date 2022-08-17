import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'loginpage.dart';

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
            image: AssetImage('assets/image/fundo.png'), fit: BoxFit.cover),
      ),
      //imagem da logo SETH.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 170, bottom: 100),
            child: Image(
              image: AssetImage('assets/image/logomarca.png'),
              height: 200,
            ),
          ),
          //Paddin para mover as imagens na tela.
          Padding(
            padding: const EdgeInsets.only(top: 200),
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
                )),
          )
        ],
      ),
    );
  }
}
