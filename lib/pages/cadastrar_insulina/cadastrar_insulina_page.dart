import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vencimento_de_insulina/pages/cadastrar_insulina/cadastrar_insulina_controller.dart';
import 'package:vencimento_de_insulina/shared/input_text/input_text_widget.dart';
import 'package:vencimento_de_insulina/shared/state_app/state_app.dart';

class CadastrarInsulinaPage extends StatefulWidget {
  const CadastrarInsulinaPage({Key? key}) : super(key: key);

  @override
  _CadastrarInsulinaPageState createState() => _CadastrarInsulinaPageState();
}

class _CadastrarInsulinaPageState extends State<CadastrarInsulinaPage> {
  final controller = CadastrarInsulinaController();
  final dataAberturaController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    dataAberturaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Insulina",
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
      body: Container(
        height: size.height,
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InputTextWidget(
                      label: "Qual o nome da insulina?",
                      icon: FontAwesomeIcons.syringe,
                      textInputType: TextInputType.name,
                      onChanged: (value) {
                        controller.onChange(nome: value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "É necessário informar o nome da insulina";
                        }
                        return null;
                      },
                    ),
                    InputTextWidget(
                      readOnly: true,
                      label: "Quando você abriu a insulina?",
                      icon: FontAwesomeIcons.calendarAlt,
                      textInputType: TextInputType.name,
                      onChanged: (value) {
                        controller.onChange(nome: value);
                      },
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2100),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            dataAberturaController.text =
                                DateFormat('dd/MM/yyyy').format(selectedDate);
                            controller.onChange(
                              dataAbertura: selectedDate,
                            );
                          }
                        });
                      },
                      controller: dataAberturaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "É necessário informar a data de abertura da insulina";
                        }
                        return null;
                      },
                    ),
                    InputTextWidget(
                      label: "Válida por quantos dias?",
                      icon: FontAwesomeIcons.calendarTimes,
                      textInputType: TextInputType.number,
                      onChanged: (value) {
                        if (value != null && value.isNotEmpty) {
                          controller.onChange(
                            diasValidade: int.parse(value),
                          );
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "É necessário informar os dias válidos da insulina";
                        } else if (int.parse(value) == 0) {
                          return "O valor deve sair maior que zero.";
                        }
                        return null;
                      },
                    ),
                    InputTextWidget(
                      label: "Quantos ml a insulina possui?",
                      icon: FontAwesomeIcons.vial,
                      textInputType: TextInputType.number,
                      onChanged: (value) {
                        if (value != null && value.isNotEmpty) {
                          controller.onChange(
                            mililitro: int.parse(value),
                          );
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "É necessário informar os dias válidos da insulina";
                        } else if (int.parse(value) == 0) {
                          return "O valor deve sair maior que zero.";
                        }
                        return null;
                      },
                    ),
                    InputTextWidget(
                      label: "Quantos ui cada ml possui?",
                      icon: FontAwesomeIcons.vial,
                      textInputType: TextInputType.number,
                      onChanged: (value) {
                        if (value != null && value.isNotEmpty) {
                          controller.onChange(
                            uiMililitro: int.parse(value),
                          );
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "É necessário informar o ui por ml da insulina";
                        } else if (int.parse(value) == 0) {
                          return "O valor deve sair maior que zero.";
                        }
                        return null;
                      },
                    ),
                    InputTextWidget(
                      label: "Quantos ui você usa por dia?",
                      icon: FontAwesomeIcons.burn,
                      textInputType: TextInputType.number,
                      onChanged: (value) {
                        if (value != null && value.isNotEmpty) {
                          controller.onChange(
                            uiDiario: int.parse(value),
                          );
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "É necessário informar o ui por dia da insulina";
                        } else if (int.parse(value) == 0) {
                          return "O valor deve sair maior que zero.";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 26),
                      child: ValueListenableBuilder(
                        valueListenable: controller.state,
                        builder: (_, value, __) {
                          StateApp state = value as StateApp;
                          if (state == StateApp.loading) {
                            return Container(
                              height: 56,
                              width: double.maxFinite,
                              child: Center(
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF75C44C),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                controller.cadastrar(context);
                              },
                              child: Container(
                                height: 56,
                                width: double.maxFinite,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF75C44C),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
