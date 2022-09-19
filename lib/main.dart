import 'package:flutter/material.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'frontEnd/geral/Homepage.dart';

void main(List<String> args) async {
  final server = await shelf_io.serve(
      (request) => Response(200, body: "ok"), 'localhost', 8080);
  print("object server = http://localhost:8080");
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
