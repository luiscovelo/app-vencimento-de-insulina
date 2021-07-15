import 'package:flutter/material.dart';
import 'package:vencimento_de_insulina/pages/cadastrar_insulina/cadastrar_insulina_page.dart';
import 'package:vencimento_de_insulina/pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Controle de vencimento de insulinas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomePage(),
        "/cadastrar": (context) => CadastrarInsulinaPage(),
      },
    );
  }
}
