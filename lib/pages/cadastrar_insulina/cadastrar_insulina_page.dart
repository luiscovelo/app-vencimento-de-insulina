import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vencimento_de_insulina/pages/cadastrar_insulina/cadastrar_insulina_controller.dart';

class CadastrarInsulinaPage extends StatefulWidget {
  const CadastrarInsulinaPage({Key? key}) : super(key: key);

  @override
  _CadastrarInsulinaPageState createState() => _CadastrarInsulinaPageState();
}

class _CadastrarInsulinaPageState extends State<CadastrarInsulinaPage> {
  final controller = CadastrarInsulinaController();
  final dataAberturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova insulina"),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.text_fields_outlined),
                labelText: "Qual nome da insulina?",
              ),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                controller.onChange(nome: value);
              },
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                icon: Icon(Icons.event_busy_outlined),
                labelText: 'Quando você abriu a insulina?',
              ),
              controller: dataAberturaController,
              onTap: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    dataAberturaController.text =
                        DateFormat('dd-MM-yyyy').format(selectedDate);
                    controller.onChange(
                      dataAbertura: selectedDate,
                    );
                  }
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.event_busy_outlined),
                labelText: "Ele é válido por quantos dias?",
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.onChange(
                  diasValidade: int.parse(value),
                );
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.opacity_outlined),
                labelText: "Quantos ml possui o frasco/caneta?",
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.onChange(
                  mililitro: int.parse(value),
                );
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.opacity_outlined),
                labelText: "Quantos UI cada ml possui?",
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.onChange(
                  uiMililitro: int.parse(value),
                );
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.edit_location_alt_outlined),
                labelText: "Quantos UI você usa por dia?",
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                controller.onChange(
                  uiDiario: int.parse(value),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton.icon(
        icon: Icon(Icons.save),
        label: Text("Inserir insulina"),
        onPressed: () {
          controller.cadastrar(context);
        },
      ),
    );
  }
}
