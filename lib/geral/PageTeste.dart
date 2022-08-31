import 'package:flutter/material.dart';
import '../telasProf/CadProfessor.dart';
import '../telasProf/ValPresenca.dart';

class PageTest extends StatefulWidget {
  const PageTest({Key? key}) : super(key: key);
  @override
  State<PageTest> createState() => _PageTestState();
}

class _PageTestState extends State<PageTest> {
  bool isChecked = false;
  bool showPassword = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CadProfessor()),
                    );
                  },
                  child: const Text(
                    "CadProfessor",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              const Padding(padding: EdgeInsets.only(top: 30)),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ValPresenca()),
                    );
                  },
                  child: const Text(
                    "ValPresenca",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
