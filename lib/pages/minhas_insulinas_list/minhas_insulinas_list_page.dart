import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vencimento_de_insulina/pages/minhas_insulinas_list/minhas_insulinas_controller.dart';
import 'package:vencimento_de_insulina/shared/state_app/state_app.dart';

class MinhasInsulinasListPage extends StatefulWidget {
  const MinhasInsulinasListPage({Key? key}) : super(key: key);

  @override
  _MinhasInsulinasListPageState createState() =>
      _MinhasInsulinasListPageState();
}

class _MinhasInsulinasListPageState extends State<MinhasInsulinasListPage> {
  final controller = MinhasInsulinasController();

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await controller.buscarTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (_, value, __) {
          StateApp state = value as StateApp;
          if (state == StateApp.loading) {
            return CircularProgressIndicator();
          } else if (state == StateApp.success) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.buscarTodos();
              },
              child: ListView.builder(
                itemCount: controller.insulinas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.insulinas[index].nome!),
                    subtitle: Text(
                      "Vence dia: " +
                          controller.formatarData(
                              controller.insulinas[index].dataVencimento!),
                    ),
                    trailing: Icon(Icons.navigate_next_outlined),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  controller.buscarTodos();
                },
                icon: Icon(Icons.refresh_outlined),
                label: Text("Tentar novamente"),
              ),
            );
          }
        },
      ),
    );
  }
}
