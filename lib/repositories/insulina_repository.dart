import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vencimento_de_insulina/models/insulina_model.dart';

class InsulinaRepository {
  Future cadastrar(InsulinaModel novaInsulina) async {
    try {
      final instance = await SharedPreferences.getInstance();
      List<String> insulinas = await _getInsulinasByStore();
      insulinas.add(novaInsulina.toJson());

      await instance.setStringList("insulinas", insulinas);
    } catch (e) {
      throw e;
    }
  }

  Future<List<InsulinaModel>> list() async {
    List<InsulinaModel> insulinas = [];
    try {
      final response = await _getInsulinasByStore();
      insulinas = response.map((e) => InsulinaModel.fromJson(e)).toList();
      return insulinas;
    } catch (e) {
      throw e;
    }
  }

  Future<InsulinaModel> buscarPorId(String id) async {
    List<InsulinaModel> insulinas = [];
    InsulinaModel insulina = InsulinaModel();
    try {
      List<String> response = await _getInsulinasByStore();
      insulinas = response.map((e) => InsulinaModel.fromJson(e)).toList();
      insulina = insulinas.firstWhere((element) => element.id == id);
      return insulina;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> removerPorId(String id) async {
    List<InsulinaModel> insulinas = [];
    InsulinaModel insulina = InsulinaModel();
    try {
      List<String> response = await _getInsulinasByStore();

      insulinas = response.map((e) => InsulinaModel.fromJson(e)).toList();
      insulinas = insulinas.where((element) => element.id != id).toList();

      List<String> result = insulinas.map((e) => e.toJson()).toList();

      final instance = await SharedPreferences.getInstance();
      await instance.setStringList("insulinas", result);

      return true;
    } catch (e) {
      throw e;
    }
  }

  Future<List<String>> _getInsulinasByStore() async {
    try {
      final instance = await SharedPreferences.getInstance();
      if (instance.containsKey("insulinas")) {
        final response = instance.getStringList("insulinas") ?? <String>[];
        return response;
      }
      return <String>[];
    } catch (e) {
      throw e;
    }
  }
}
