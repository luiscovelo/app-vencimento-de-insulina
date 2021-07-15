import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vencimento_de_insulina/models/insulina_model.dart';
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
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == StateApp.success) {
            if (controller.insulinas.length > 0) {
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.buscarTodos();
                },
                child: ListView.builder(
                  itemCount: controller.insulinas.length,
                  itemBuilder: (context, index) {
                    InsulinaModel item = controller.insulinas[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                "/detalhes",
                                arguments: item.id,
                              );
                            },
                            child: AnimatedCard(
                              direction: AnimatedCardDirection.left,
                              child: ListTile(
                                title: Text(
                                  item.nome!,
                                  style: GoogleFonts.inter(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Text.rich(
                                    TextSpan(
                                      text: "Vence em ",
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: controller.formatarData(
                                              item.dataVencimento),
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " ou até ",
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              item.totalDeAplicacoes.toString(),
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " dose(s)",
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                trailing: Text(
                                  controller.formatarData(item.dataAbertura) +
                                      " ->",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Container(
                  child: Text(
                    "Você ainda não cadastrou nenhuma insulina.",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              );
            }
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
