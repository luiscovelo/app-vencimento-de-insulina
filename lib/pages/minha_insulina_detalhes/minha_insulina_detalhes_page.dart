import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vencimento_de_insulina/pages/minha_insulina_detalhes/minha_insulina_controller.dart';
import 'package:vencimento_de_insulina/shared/input_detail/input_detail_widget.dart';
import 'package:vencimento_de_insulina/shared/state_app/state_app.dart';

class MinhaInsulinaDetalhesPage extends StatefulWidget {
  final String id;
  const MinhaInsulinaDetalhesPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _MinhaInsulinaDetalhesPageState createState() =>
      _MinhaInsulinaDetalhesPageState();
}

class _MinhaInsulinaDetalhesPageState extends State<MinhaInsulinaDetalhesPage> {
  final controller = MinhaInsulinaController();

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    await controller.init(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Informações",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home");
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.black,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (_, value, __) {
          StateApp state = value as StateApp;
          if (state == StateApp.loading) {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state == StateApp.success) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        InputDetailWidget(
                          icon: FontAwesomeIcons.syringe,
                          label: "Nome da insulina",
                          text: controller.insulina.nome!,
                        ),
                        InputDetailWidget(
                          icon: FontAwesomeIcons.calendarAlt,
                          label: "Data da abertura",
                          text: controller
                              .formatarData(controller.insulina.dataAbertura),
                        ),
                        InputDetailWidget(
                          icon: FontAwesomeIcons.calendarTimes,
                          label: "Dias de validade",
                          text: controller.insulina.diasValidade.toString() +
                              " dia(s)",
                        ),
                        InputDetailWidget(
                          icon: FontAwesomeIcons.calendarTimes,
                          label: "Data do vencimento",
                          text: controller
                              .formatarData(controller.insulina.dataVencimento),
                        ),
                        InputDetailWidget(
                          icon: FontAwesomeIcons.vial,
                          label: "Quantidade de mililitro por frasco/caneta",
                          text:
                              controller.insulina.mililitro.toString() + " ml",
                        ),
                        InputDetailWidget(
                          icon: FontAwesomeIcons.burn,
                          label: "Quantidade de ui por mililitro",
                          text: controller.insulina.uiMililitro.toString() +
                              " ui",
                        ),
                        InputDetailWidget(
                          icon: FontAwesomeIcons.burn,
                          label: "Quantidade de ui de uso diário",
                          text: controller.insulina.uiDiario.toString() + " ui",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26),
                    child: InkWell(
                      onTap: () async {
                        bool result = await controller.removerPorId(widget.id);
                        if (result) {
                          Navigator.pushReplacementNamed(context, "/home");
                        }
                      },
                      child: Container(
                        height: 56,
                        width: double.maxFinite,
                        child: Icon(
                          FontAwesomeIcons.trashAlt,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[400],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Container(
                child: ElevatedButton.icon(
                  icon: Icon(
                    FontAwesomeIcons.redo,
                    size: 13,
                  ),
                  label: Text("Tentar novamente"),
                  onPressed: () async {
                    controller.init(widget.id);
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
