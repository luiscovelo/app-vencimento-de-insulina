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
