import 'package:flutter/material.dart';
import 'Lista.dart';
import 'PrimeiraTela.dart';
import 'Receitas.dart'; // Importar a página de Receitas
import 'Perfil.dart'; // Importar a página de Perfil
import 'Publicar.dart'; // Importar a página de Publicar

List<Map<String, dynamic>> listaDeCompras = [];
final GlobalKey<_InicioState> _inicioKey = GlobalKey<_InicioState>();

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Inicio(key: _inicioKey), // Passando a chave para o Inicio
  ));
}

class Inicio extends StatefulWidget {
  Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _indiceAtual = 0;
  final List<Widget> _telas = [
    PrimeiraTela(),
    Publicar(), // Tela de Publicar
    Receitas(),
    ListaScreen(), // Tela de Lista
  ];

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  void mudarParaReceitas() {
    setState(() {
      _indiceAtual = 2; // Muda para a página de Receitas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            setState(() {
              _indiceAtual = 0; // Volta para a tela inicial
            });
          },
          child: SizedBox(
            width: 120,
            height: 50,
            child: Image.asset(
              'assets/images/RecipeWiseLogo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        backgroundColor: Color(0xFF942B2B),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Perfil()), // Navega para a tela de Perfil
              );
            },
          ),
        ],
      ),
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início", backgroundColor: Color(0xFF942B2B)),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Publicar", backgroundColor: Color(0xFF942B2B)),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Receitas", backgroundColor: Color(0xFF942B2B)),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Lista", backgroundColor: Color(0xFF942B2B)),
        ],
      ),
    );
  }
}
