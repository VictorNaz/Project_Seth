import 'package:flutter/material.dart';
import 'package:flutter_project_seth/telasAluno/DesempAluno.dart';
import 'package:flutter_project_seth/telasMestre/CadProfessor.dart';
import 'package:flutter_project_seth/telasProf/ValPresenca.dart';
import 'package:flutter_project_seth/widgets/utilClass.dart';

class MenuMestre extends StatefulWidget {
  const MenuMestre({Key? key}) : super(key: key);

  @override
  State<MenuMestre> createState() => _MenuMestreState();
}

class _MenuMestreState extends State<MenuMestre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Text("Menu Mestre"),

        //Icone de voltar quando utilizado o drawer no appbar
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context, false)),
      ),

      //drawer para navegação no appbar
      //A classe Drawer está sendo chamada de outro arquivo e está recebendo por parametro o texto desejado.
      endDrawer: const Drawer(
        child: DrawerTop(
          texto: "Opções",
        ),
      ),
      //corpo
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            //imagem de backgroud.
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/fundo5.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          //Posicionamento do campo ao selecionar o campo
          SingleChildScrollView(
            child: Column(
              children: [
                //botão cadastrar Professor
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CadProfessor()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                    fixedSize: const Size(320, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.group_add_outlined,
                        size: 50,
                        color: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.only(right: 60)),
                      Text(
                        "Cadastrar \n Professor",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ValPresenca()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                    fixedSize: const Size(320, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.fact_check_outlined,
                        size: 50,
                        color: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.only(right: 60)),
                      Text(
                        "Presença",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DesempAluno()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                    fixedSize: const Size(320, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.add_chart_rounded,
                        size: 50,
                        color: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.only(right: 25)),
                      Text(
                        "Desempenho dos \n Alunos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ValPresenca()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                    fixedSize: const Size(320, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.grading_sharp,
                        size: 50,
                        color: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.only(right: 60)),
                      Text(
                        "Relatórios",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),

                ElevatedButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                    fixedSize: const Size(320, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 50,
                        color: Colors.black,
                      ),
                      Padding(padding: EdgeInsets.only(right: 50)),
                      Text(
                        "Informações",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 80)),
              ],
            ),
          ),
        ],
      ),

      //botão flutuante sobre a barra inferior

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MenuMestre()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        elevation: 2.0,
        child: const Icon(
          Icons.home,
          color: Colors.black,
          size: 35,
        ),
      ),

      //barra infeirior
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.black,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: (null),
              icon: const Icon(
                Icons.person,
                color: Color.fromARGB(255, 252, 72, 27),
                size: 35,
              ),
            ),
            const IconButton(
              onPressed: null,
              icon: Icon(
                Icons.exit_to_app,
                color: Color.fromARGB(255, 252, 72, 27),
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
