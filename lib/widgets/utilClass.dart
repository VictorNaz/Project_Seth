import 'package:flutter/material.dart';

class DrawerTop extends StatelessWidget {
  const DrawerTop({Key? key, required this.texto}) : super(key: key);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 252, 72, 27)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.settings),
              const Padding(padding: EdgeInsets.only(right: 20)),
              Text(
                texto,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
