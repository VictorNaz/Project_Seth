import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/image/fundo.png'))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(
              'assets/image/logomarca.png',
            ),
          ),
          TextButton(
              onPressed: null,
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: const Size(350, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ],
      ),
    );
  }
}
