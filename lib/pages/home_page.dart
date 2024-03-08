import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarefas_getx_app/model/tarefa_model.dart';
import 'package:tarefas_getx_app/repository/tarefa_controller.dart';
import 'package:tarefas_getx_app/repository/tarefa_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tarefaRepository = TarefaRepository();

  TarefaController controller =
      TarefaController(repository: TarefaRepository());

  // List<Tarefa> tarefas = <Tarefa>[].obs;

  var descricaoContoller = TextEditingController();

  var apenasNaoConcluidos = false;

  var carregando = false;

  obterDados() async {
    controller.obterTarefas(apenasNaoConcluidos);
  }

  @override
  void initState() {
    obterDados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // obterDados();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Tarefas com GetX",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const Text(
              "Apenas Não Concluidas: ",
              style: TextStyle(fontSize: 18),
            ),
            Obx(() {
              return Switch(
                  value: controller.apenasNaoConcluidos,
                  onChanged: (apenasNaoConcluidos) {
                    controller.setApenasNaoConcluidos(apenasNaoConcluidos);
                    obterDados();
                  });
            })
          ]),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                  itemCount: controller.tarefas.length,
                  itemBuilder: (BuildContext context, int index) {
                    var tarefa = controller.tarefas[index];
                    return Dismissible(
                      onDismissed: (DismissDirection direction) async {
                        tarefaRepository.remover(tarefa.objectId);
                        obterDados();
                      },
                      key: Key(tarefa.objectId),
                      child: ListTile(
                        title: Text(tarefa.descricao),
                        trailing: Switch(
                          value: tarefa.concluido,
                          onChanged: (bool value) async {
                            tarefaRepository.alterar(Tarefa(tarefa.objectId,
                                tarefa.descricao, value, "", ""));
                            obterDados();
                          },
                        ),
                      ),
                    );
                  });
            }),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descricaoContoller.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Adicionar Tarefa"),
                  content: TextField(controller: descricaoContoller),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar")),
                    Obx(() {
                      return TextButton(
                          onPressed: () async {
                            // tarefaRepository.criar(TarefaAppModel.criar(
                            //     descricaoContoller.text, false));
                            tarefaRepository.adicionar(Tarefa(
                                "", descricaoContoller.text, false, "", ""));
                            // obterDados();
                            Navigator.pop(context);
                            // setState(() {});
                          },
                          child: const Text("Salvar"));
                    })
                  ],
                );
              });
        },
        tooltip: 'Adicionar Tarefa',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
