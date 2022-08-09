import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'loginpage.dart';

class ProjectSeth extends StatelessWidget {
  const ProjectSeth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginPage());
  }
}
