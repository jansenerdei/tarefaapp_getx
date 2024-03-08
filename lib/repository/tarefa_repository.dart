import 'package:tarefas_getx_app/model/tarefa_model.dart';
import 'package:tarefas_getx_app/repository/app_custom_dio.dart';

class TarefaRepository {
  final _customDio = AppCustomDio();

  TarefaRepository();

  // Future<Tarefas> obterTarefas(bool concluido) async {
  //   var url = "/Tarefas";
  //   if (concluido) {
  //     url = "$url?where={\"concluido\":false}";
  //   }
  //   var result = await _customDio.dio.get(url);
  //   return Tarefas.fromJson(result.data);
  // }

  Future<void> adicionar(Tarefa tarefa) async {
    try {
      await _customDio.dio.post("/Tarefas", data: tarefa.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> alterar(Tarefa tarefa) async {
    try {
      await _customDio.dio
          .put("/Tarefas/${tarefa.objectId}", data: tarefa.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String id) async {
    try {
      await _customDio.dio.delete("/Tarefas?$id");
    } catch (e) {
      rethrow;
    }
  }
}
