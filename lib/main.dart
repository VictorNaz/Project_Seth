import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/widgets/splashScreen.dart';


void main(List<String> args) {
  runApp(const ProjectSeth());
}

class ProjectSeth extends StatelessWidget {
  const ProjectSeth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //após fechar o app, verificar se o isAuth tem valor
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
