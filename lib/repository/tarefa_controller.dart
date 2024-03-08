import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tarefas_getx_app/model/tarefa_model.dart';
import 'package:tarefas_getx_app/repository/app_custom_dio.dart';
import 'package:tarefas_getx_app/repository/tarefa_repository.dart';
import 'package:get/get_rx/get_rx.dart';

class TarefaController extends GetxController {
  final _customDio = AppCustomDio();
  final TarefaRepository repository;

  TarefaController({required this.repository});

  List<Tarefa> get tarefas => _tarefas.toList();

  void setTarefas() {
    _tarefas.value = taskList.tarefas;
  }

  var taskList = Tarefas([]);

  final RxList<Tarefa> _tarefas = <Tarefa>[].obs;

  final _apenasNaoConcluidos = false.obs;

  bool get apenasNaoConcluidos => _apenasNaoConcluidos.value;

  void setApenasNaoConcluidos(bool value) {
    _apenasNaoConcluidos.value = value;
  }

  Future<Tarefas> obterTarefas(bool concluido) async {
    var url = "/Tarefas";
    if (_apenasNaoConcluidos.value) {
      url = "$url?where={\"concluido\":false}";
    }
    var result = await _customDio.dio.get(url);

    taskList = Tarefas.fromJson(result.data);

    _tarefas.value = taskList.tarefas;

    return taskList;
  }
}
