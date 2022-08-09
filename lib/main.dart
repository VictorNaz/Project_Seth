import 'package:flutter/material.dart';

import 'projectseth.dart';

void main(List<String> args) {
  runApp(const ProjectSeth());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/image_login.png'),
                fit: BoxFit.fill)),
      ),
    );
  }
}
