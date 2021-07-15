import 'package:flutter/material.dart';
import 'package:vencimento_de_insulina/pages/minhas_insulinas_list/minhas_insulinas_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas insulinas"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: MinhasInsulinasListPage(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/cadastrar");
        },
      ),
    );
  }
}
