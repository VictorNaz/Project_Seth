// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_project_seth/backEnd/controladora/CtrlAluno.dart';
import 'package:kg_charts/kg_charts.dart';
import 'package:flutter_project_seth/backEnd/security/sessionService.dart';

import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/server/serverAluno.dart';
import '../widgets/utilClass.dart';

class Auto_Avaliacao extends StatefulWidget {
  const Auto_Avaliacao({Key? key}) : super(key: key);

  @override
  State<Auto_Avaliacao> createState() => _Auto_AvaliacaoState();
}

class _Auto_AvaliacaoState extends State<Auto_Avaliacao> {
  double valAlimentacao = 1;
  double valPrevencao = 1;
  double valAtivFisica = 1;
  double valAutoControle = 1;
  double valRelacionamento = 1;
  double valEspiritual = 1;
  double valDefPessoal = 1;
  String usuario = "";

  List<double> lista = [];

  String nome = "";
  String email = "";
  var aluno = Aluno();

  getInfoAluno<Aluno>() async {
    aluno.usuario = await PrefsService.returnUser();
    await ServerAluno.buscaInfo(aluno).then((value) {
      setState(() {
        aluno = value;
        nome = aluno.nome!;
        email = aluno.email!;
      });
    });
  }

  //O comando getList serve para podermos mudar o tipo do retorno da buscaAvaliacao
  //de Future<list<double>> para list<double>, alem de setar o valor em uma variavel global
  //Este método irá coletar o usuario da sessão e passará por parametro para outro método na CtrlAluno

  getList<List>() async {
    var aluno = Aluno();
    aluno.usuario = await PrefsService.returnUser();

    await buscaAvaliacao(aluno).then((value) {
      setState(() {
        lista = value;
        usuario = aluno.usuario!;
      });
    });
  }

  @override

  //O comando abaixo define a inicialização do getList antes do carregamento da pagina
  void initState() {
    getList();
    getInfoAluno();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: const Center(
          child: Text("Auto Avaliação"),
        ),
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
      endDrawer: Drawer(
                backgroundColor: Color.fromARGB(207, 255, 255, 255),

        child: DrawerTop(
          texto: "Opções",
          nome: nome,
          email: email,
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          //Comando utilizado para que o texto quando ultrapasse o limite da tela cria uma barra de rolagem.
          physics: const BouncingScrollPhysics(),

          //Comando para colocar o conteúdo em coluna
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Esta classe retorna um card com um expansionTile dentro, recebendo o titulo e a descrição do mesmo.
              Card(
                //Determinamos o raio das bordas do card
                shape: (RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),

                //ClopRRect serve para que o texto não ultrapasse os raios do card
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),

                  //SingleChildScrollView serve para o texto quando expandido não ultrapasse o tamanho da tela
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ExpansionTile(
                      //determinamos as cores do botão quando aberto e fechado
                      textColor: const Color.fromARGB(255, 0, 0, 0),
                      collapsedBackgroundColor:
                          const Color.fromARGB(255, 73, 72, 72),
                      collapsedTextColor: Colors.white,
                      backgroundColor: Colors.white,
                      childrenPadding: const EdgeInsets.all(16),
                      //titulo do botão
                      title: const Text(
                        "       Última Avaliação",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RadarWidget(
                              radarMap: RadarMapModel(
                                legend: [
                                  LegendModel('Desempenho',
                                      const Color.fromARGB(255, 252, 72, 27)),
                                ],
                                indicator: [
                                  IndicatorModel("Alimentação", 10),
                                  IndicatorModel("Prevenção", 10),
                                  IndicatorModel("Atividade \n Fisica", 10),
                                  IndicatorModel("Comportamento", 10),
                                  IndicatorModel("Relacionamento", 10),
                                  IndicatorModel("Espiritual", 10),
                                  IndicatorModel("Defesa \n Pessoal", 10),
                                ],
                                data: [
                                  MapDataModel(lista),
                                ],
                                radius: 100,
                                duration: 2000,
                                shape: Shape.square,
                                maxWidth: 90,
                                line: LineModel(10),
                              ),
                              textStyle: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              isNeedDrawLegend: true,
                              lineText: (p, length) => "${(p + 1 ~/ length)}",
                              dilogText: (IndicatorModel indicatorModel,
                                  List<LegendModel> legendModels,
                                  List<double> mapDataModels) {
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
                              //outLineText: (data, max) => "${data}",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              //espaçamento entre campos
              const Padding(padding: EdgeInsets.only(top: 20)),

              //texto de titulo
              Card(
                child: const SizedBox(
                  child: Center(
                    child: Text(
                      "Fazer avaliação",
                      style: TextStyle(
                        color: Color.fromRGBO(252, 250, 250, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  width: 250,
                  height: 32,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: const Color.fromARGB(255, 73, 72, 72),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),

              //Cards contendo os selects de avaliação
              Card(
                color: const Color.fromARGB(255, 226, 226, 226),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Alimentação: ",
                    ),
                    Slider(
                      value: valAlimentacao,
                      max: 10,
                      divisions: 10,
                      label: valAlimentacao.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          valAlimentacao = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Prevenção: ",
                    ),
                    Slider(
                      value: valPrevencao,
                      max: 10,
                      divisions: 10,
                      label: valPrevencao.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          valPrevencao = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 226, 226, 226),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Atividade Fisica: ",
                    ),
                    Slider(
                      value: valAtivFisica,
                      max: 10,
                      divisions: 10,
                      label: valAtivFisica.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          valAtivFisica = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Auto_controle: ",
                    ),
                    Slider(
                      value: valAutoControle,
                      max: 10,
                      divisions: 10,
                      label: valAutoControle.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          valAutoControle = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 226, 226, 226),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Relacionamento: ",
                    ),
                    Slider(
                      value: valRelacionamento,
                      max: 10,
                      divisions: 10,
                      label: valRelacionamento.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          valRelacionamento = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Espiritual: ",
                    ),
                    Slider(
                      value: valEspiritual,
                      max: 10,
                      divisions: 10,
                      label: valEspiritual.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          valEspiritual = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 226, 226, 226),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Defesa Pessoal: ",
                    ),
                    Slider(
                      value: valDefPessoal,
                      max: 10,
                      divisions: 10,
                      label: valDefPessoal.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          valDefPessoal = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),

              Card(
                child: SizedBox(
                  child: TextButton(
                    child: const Text(
                      "Enviar Avaliação",
                      style: TextStyle(
                        color: Color.fromRGBO(252, 250, 250, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      cadAvaliacao(
                          valAlimentacao,
                          valPrevencao,
                          valAtivFisica,
                          valAutoControle,
                          valRelacionamento,
                          valEspiritual,
                          valDefPessoal);
                      Navigator.pop(context, false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Avaliação casdastrada com sucesso')),
                      );
                    },
                  ),
                  width: 250,
                  height: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: const Color.fromARGB(255, 252, 72, 27),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 120))
            ],
          ),
        ),
      ),

      //botão flutuante sobre a barra inferior
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, false);
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
