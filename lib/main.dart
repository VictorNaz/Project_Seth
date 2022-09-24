import 'package:flutter/material.dart';
import 'frontEnd/geral/Homepage.dart';

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
