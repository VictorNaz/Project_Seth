import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kg_charts/kg_charts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../backEnd/controladora/CtrlAluno.dart';
import '../../backEnd/modelo/aluno.dart';
import '../../backEnd/security/sessionService.dart';
import '../../backEnd/server/serverAluno.dart';
import '../widgets/utilClass.dart';

class DetalheProgresso extends StatefulWidget {
  final String nome;
  const DetalheProgresso({
    Key? key,
    required this.nome,
  }) : super(key: key);

  @override
  State<DetalheProgresso> createState() => _DetalheAlunoState();
}

class _DetalheAlunoState extends State<DetalheProgresso> {
  List<double> lista = [];
  int quantAulas = 0;
  double percAulas = 0;
  String? faixa = "...";
  String? grau = "...";

  NumberFormat formatter = NumberFormat("00.0");

  String nome = "";
  String email = "";
  var aluno = Aluno();

  //A instancia mestre do tipo aluno carrega as informações do usuario da seção principal
  var mestre = Aluno();
  //Esse método serve para carregar as informações do usuario logado para mostrar no drower
  getInfoAluno<Aluno>() async {
    mestre.usuario = await PrefsService.returnUser();
    await ServerAluno.buscaInfo(mestre).then((value) {
      setState(() {
        mestre = value;
        nome = mestre.nome!;
        email = mestre.email!;
      });
    });
  }

  // serve para podermos mudar o tipo do retorno da buscaAvaliacao
  //de Future<list<double>> para list<double>, alem de setar o valor em uma variavel global
  //este método recebe o usuario como um parametro da classe DetalheProgresso
  getInfoUsuario<List>() async {
    aluno.nome = widget.nome;
    aluno.usuario = await buscaUsarioPorNome(aluno);
    print(aluno.usuario);
    await buscaAvaliacao(aluno).then((value) {
      setState(() {
        lista = value;
      });
    });
    //este serve para pegar o valor do backend da quantidade de aulas frequentadas quando a página é carregada
    //alem de setar o valor após a coleta dos dados.
    //este método recebe o usuario como um parametro da classe DetalheProgresso
    await buscaAulas(aluno).then((value) {
      if (value != null) {
        setState(() {
          quantAulas = value;
          percAulas = (quantAulas / 250) * 100;
        });
      }
    });
    aluno = await buscaInfo(aluno);
    await buscaFaixa(aluno).then((value) {
      setState(() {
        faixa = value.faixa;
        grau = value.grau.toString();
      });
    });
  }

  @override

  //O comando abaixo define a inicialização do getList antes do carregamento da pagina
  void initState() {
    getInfoUsuario();
    getInfoAluno();
    super.initState();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        //Barra superior já com o icone de voltar
        backgroundColor: const Color.fromARGB(255, 252, 72, 27),
        title: Center(
          child: Text("Aluno: ${aluno.nome}"),
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
        child: DrawerTop(
          texto: "Opções",
          nome: nome,
          email: email,
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            //imagem de backgroud.
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/fundo1.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // Esta classe retorna um card com um expansionTile dentro, recebendo o titulo e a descrição do mesmo.
                Card(

                    //Determinamos o raio das bordas do card
                    shape: (RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),

                    //determinamos a cor do card
                    //color: const Color.fromARGB(255, 252, 72, 27),

                    //ClopRRect serve para que o texto não ultrapasse os raios do card
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),

                      //SingleChildScrollView serve para o texto quando expandido não ultrapasse o tamanho da tela
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),

                        //ExpansionTile é um botão que se expande mostrando informações adicionais
                        child: ExpansionTile(
                          //mantem a caixa de texto aberta quando carregada a página
                          //*initiallyExpanded: true,
                          //determinamos as cores do botão quando aberto e fechado
                          textColor: const Color.fromARGB(255, 252, 72, 27),
                          collapsedBackgroundColor:
                              const Color.fromARGB(255, 252, 72, 27),
                          collapsedTextColor: Colors.white,
                          backgroundColor: Colors.white,
                          childrenPadding: const EdgeInsets.all(16),
                          //titulo do botão
                          title: const Text(
                            "Desempenho",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),

                          //texto quando expandido
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Faixa Atual:",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const Padding(padding: EdgeInsets.only(top: 7)),
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    animation: true,
                                    lineHeight: 25.0,
                                    animationDuration: 2000,
                                    percent: quantAulas / 250,
                                    center: Text(
                                      "$faixa °$grau",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    barRadius: const Radius.circular(16),
                                    progressColor: Colors.blue,
                                    backgroundColor: const Color.fromARGB(
                                        252, 207, 203, 203),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 10)),
                                Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10)),
                                    Text("$quantAulas/250 Aulas"),
                                    const Padding(
                                        padding: EdgeInsets.only(right: 125)),
                                    Text(
                                        "${formatter.format(percAulas)}% Concluído"),
                                  ],
                                ),
                                /*const Padding(
                                    padding: EdgeInsets.only(bottom: 20)),
                                const Text(
                                  "Progresso Fundamental",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const Padding(padding: EdgeInsets.only(top: 7)),
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    animation: true,
                                    lineHeight: 25.0,
                                    animationDuration: 2000,
                                    percent: 0.8,
                                    barRadius: const Radius.circular(16),
                                    progressColor:
                                        const Color.fromARGB(255, 252, 72, 27),
                                    backgroundColor: const Color.fromARGB(
                                        252, 207, 203, 203),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 10)),
                                Row(
                                  children: const [
                                    Padding(padding: EdgeInsets.only(left: 10)),
                                    Text("50/60 Aulas"),
                                    Padding(
                                        padding: EdgeInsets.only(right: 150)),
                                    Text("80% Concluído")
                                  ],
                                ),*/
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                //Espaçamento entre botões
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                // Esta classe retorna um card com um expansionTile dentro, recebendo o titulo e a descrição do mesmo.
                Card(

                    //Determinamos o raio das bordas do card
                    shape: (RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),

                    //determinamos a cor do card
                    //color: const Color.fromARGB(255, 252, 72, 27),

                    //ClopRRect serve para que o texto não ultrapasse os raios do card
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),

                      //SingleChildScrollView serve para o texto quando expandido não ultrapasse o tamanho da tela
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),

                        //ExpansionTile é um botão que se expande mostrando informações adicionais
                        child: ExpansionTile(
                          //determinamos as cores do botão quando aberto e fechado
                          textColor: const Color.fromARGB(255, 252, 72, 27),
                          collapsedBackgroundColor:
                              const Color.fromARGB(255, 252, 72, 27),
                          collapsedTextColor: Colors.white,
                          backgroundColor: Colors.white,
                          childrenPadding: const EdgeInsets.all(16),
                          //titulo do botão
                          title: const Text(
                            "Auto Avaliação",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),

                          //texto quando expandido
                          children: [
                            RadarWidget(
                              radarMap: RadarMapModel(
                                legend: [
                                  LegendModel('Desempenho 75%',
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
                        ),
                      ),
                    )),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                TextButton(
                    onPressed: () {
                      AlertUser();

                      //!Adicionar o atualizaProgresso
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 252, 72, 27),
                      fixedSize: const Size(402, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ), //texto do button e estilo da escrita
                    child: const Text(
                      "Aprovar Progresso",
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    )),
                const Padding(padding: EdgeInsets.only(bottom: 280)),
              ],
            ),
          ),
        ],
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

  AlertUser() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Deseja realmente aprovar o progresso do aluno?'),
        content: Text(
            'Ao confirmar na opção abaixo, o aluno ${aluno.nome} terá um novo progresso!'),
        actions: <Widget>[
          TextButton(
            //Se for selecionado Não
            onPressed: () {
              Navigator.pop(context, 'Não');
            },
            child: const Text(
              'Não',
            ),
          ),
          TextButton(
            //Se for selecionado sim
            onPressed: () async {
              await ServerAluno.atualizaProgresso(aluno);
              Navigator.pop(context, 'Sim');
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }
}