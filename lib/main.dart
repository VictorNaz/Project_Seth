import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const ProjectSeth());
}

class ProjectSeth extends StatelessWidget {
  const ProjectSeth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
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
