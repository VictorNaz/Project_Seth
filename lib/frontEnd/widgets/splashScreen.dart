
import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/geral/Homepage.dart';

//Splash Screen ao entrar no app, esta classe retorna a classe abaixo
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

//Classe com o conteúdo
class _SplashScreenState extends State<SplashScreen> {
  @override
  //metodo inicia primeiro
  //abre a tela em laranja e o icone da seth branco
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 252, 72, 27),
        child: const Center(
          child: Image(
            image: AssetImage('assets/image/logomarcabranco.png'),
          ),
        ));
  }


}


 