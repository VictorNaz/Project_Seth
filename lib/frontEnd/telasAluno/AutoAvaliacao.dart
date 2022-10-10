import 'package:flutter/material.dart';
import 'package:flutter_project_seth/frontEnd/telasAluno/menuPrincipal.dart';
import 'package:kg_charts/kg_charts.dart';
import 'package:kg_charts/src/flutter_radar_map.dart';

import '../widgets/utilClass.dart';

class AutoAvaliacao extends StatefulWidget {
  const AutoAvaliacao({Key? key}) : super(key: key);

  @override
  State<AutoAvaliacao> createState() => _AutoAvaliacaoState();
}

class _AutoAvaliacaoState extends State<AutoAvaliacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Text("Auto Avaliação"),

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

      body: Center(
        child: Column(
          children: [
            RadarWidget(
              radarMap: RadarMapModel(
                legend: [
                  LegendModel('Desempenho 10/10', const Color(0XFF0EBD8D)),
                ],
                indicator: [
                  IndicatorModel("Alimentação", 10),
                  IndicatorModel("Prevenção", 10),
                  IndicatorModel("Atividade Fisica", 10),
                  IndicatorModel("Comportamento", 10),
                  IndicatorModel("Relacionamento", 10),
                  IndicatorModel("Espiritual", 10),
                  IndicatorModel("Defesa Pessoal", 10),
                ],
                data: [
                  MapDataModel([10, 7, 8, 10, 6, 9, 10]),
                ],
                radius: 100,
                duration: 2000,
                shape: Shape.square,
                maxWidth: 70,
                line: LineModel(10),
              ),
              textStyle: const TextStyle(color: Colors.black, fontSize: 14),
              isNeedDrawLegend: true,
              lineText: (p, length) => "${(p + 1 ~/ length)}",
              dilogText: (IndicatorModel indicatorModel,
                  List<LegendModel> legendModels, List<double> mapDataModels) {
                StringBuffer text = StringBuffer("");
                for (int i = 0; i < mapDataModels.length; i++) {
                  text.write(
                      "${legendModels[i].name} : ${mapDataModels[i].toString()}");
                  if (i != mapDataModels.length - 1) {
                    text.write("\n");
                  }
                }
                return text.toString();
              },
              outLineText: (data, max) => "${data = data}",
            ),
          ],
        ),
      ),

      //botão flutuante sobre a barra inferior
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Menu()),
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
      bottomNavigationBar: const BotaoInferior(),
    );
  }
}
