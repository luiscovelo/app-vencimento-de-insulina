import 'package:flutter/cupertino.dart';
import 'package:vencimento_de_insulina/models/insulina_model.dart';
import 'package:vencimento_de_insulina/repositories/insulina_repository.dart';
import 'package:intl/intl.dart';
import 'package:vencimento_de_insulina/shared/state_app/state_app.dart';

class MinhaInsulinaController {
  final repository = InsulinaRepository();
  InsulinaModel insulina = InsulinaModel();

  final state = ValueNotifier<StateApp>(StateApp.start);

  formatarData(_date) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(_date).toString();
  }

  Future init(String id) async {
    try {
      state.value = StateApp.loading;
      insulina = await repository.buscarPorId(id);
      state.value = StateApp.success;
    } catch (e) {
      state.value = StateApp.error;
    }
  }

  Future<bool> removerPorId(String id) async {
    try {
      await repository.removerPorId(id);
      return true;
    } catch (e) {
      throw e;
    }
  }
}
