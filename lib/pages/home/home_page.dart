import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Minhas insulinas",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: MinhasInsulinasListPage(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF75C44C),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/cadastrar");
        },
      ),
    );
  }
}
