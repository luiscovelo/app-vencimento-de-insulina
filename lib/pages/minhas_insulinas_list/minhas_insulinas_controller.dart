import 'package:flutter/cupertino.dart';
import 'package:vencimento_de_insulina/models/insulina_model.dart';
import 'package:vencimento_de_insulina/repositories/insulina_repository.dart';
import 'package:vencimento_de_insulina/shared/state_app/state_app.dart';
import 'package:intl/intl.dart';

class MinhasInsulinasController {
  final repository = InsulinaRepository();
  List<InsulinaModel> insulinas = [];

  final state = ValueNotifier<StateApp>(StateApp.start);

  formatarData(_date) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date).toString();
  }

  Future buscarTodos() async {
    try {
      state.value = StateApp.loading;
      insulinas = await repository.list();
      state.value = StateApp.success;
    } catch (e) {
      state.value = StateApp.error;
      print(e);
    }
  }
}
