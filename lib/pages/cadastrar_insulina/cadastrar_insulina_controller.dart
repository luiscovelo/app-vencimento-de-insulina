import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:vencimento_de_insulina/models/insulina_model.dart';
import 'package:vencimento_de_insulina/repositories/insulina_repository.dart';

class CadastrarInsulinaController {
  final formKey = GlobalKey<FormState>();
  final repository = InsulinaRepository();
  InsulinaModel insulina = InsulinaModel();

  void onChange({
    String? nome,
    DateTime? dataAbertura,
    int? diasValidade,
    int? mililitro,
    int? uiMililitro,
    int? uiDiario,
  }) {
    insulina = insulina.copyWith(
      nome: nome,
      dataAbertura: dataAbertura,
      diasValidade: diasValidade,
      mililitro: mililitro,
      uiMililitro: uiMililitro,
      uiDiario: uiDiario,
    );
  }

  void cadastrar(BuildContext context) async {
    final form = formKey.currentState;
    final uuid = Uuid();

    String id = uuid.v4();
    int totalDoses = 0;
    double totalDeAplicacoes = 0;
    DateTime dataVencimento;

    if (form!.validate()) {
      try {
        totalDoses = (insulina.mililitro! * insulina.uiMililitro!);
        totalDeAplicacoes = totalDoses / 10;
        dataVencimento = DateTime(
          insulina.dataAbertura!.year,
          insulina.dataAbertura!.month,
          insulina.dataAbertura!.day + insulina.diasValidade!,
        );

        insulina.id = id;
        insulina.totalDeAplicacoes = totalDeAplicacoes.toInt();
        insulina.dataVencimento = dataVencimento;

        await repository.cadastrar(insulina);

        Navigator.pushReplacementNamed(context, "/home");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
