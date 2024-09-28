import 'package:flutter/material.dart';
import 'main.dart';
import 'Lista.dart';
import 'TelaBusca.dart';
import 'FavoritosTela.dart';
import 'Receitas.dart'; // Certifique-se de que o arquivo Receitas.dart esteja importado corretamente
import 'DicasTela.dart';
import 'CategoriasTela.dart';

int _paginaAtual = 0; // Controla qual tela será exibida

class PrimeiraTela extends StatefulWidget {
  @override
  _PrimeiraTelaState createState() => _PrimeiraTelaState();
}

class _PrimeiraTelaState extends State<PrimeiraTela> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _ultimasReceitas = [];

  Widget _buildIconButton(IconData icon, String label, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(16),
            child: Icon(icon, size: 24, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void _removeTextoBusca() {
    setState(() {
      _textEditingController.clear();
    });
  }

  // Funções para navegação
  void _navegarParaFavoritos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Favoritos("Tela de Favoritos")),
    );
  }

  // Modificação para levar à tela Receitas
  void _navegarParaReceitas() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Receitas()), // Chama a tela Receitas
    );
  }

  void _navegarParaDicas() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dicas("Tela de Dicas")),
    );
  }

  void _navegarParaCategorias() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Categorias("Tela de Categorias")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Barra de pesquisa
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Pesquisar...",
                          icon: Icon(Icons.search, color: Colors.red),
                        ),
                        style: TextStyle(fontSize: 18),
                        controller: _textEditingController,
                      ),
                    ),
                    // Botão de exclusão
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        _removeTextoBusca(); // Limpa o texto da barra de busca
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text("BUSCAR"),
                onPressed: () {
                  if (_textEditingController.text.isNotEmpty) {
                    setState(() {
                      _ultimasReceitas.add(_textEditingController.text);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SegundaTela(valor: _textEditingController.text),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconButton(Icons.star, "Favoritos", _navegarParaFavoritos),
                  _buildIconButton(Icons.receipt, "Receitas", _navegarParaReceitas), // Botão que navega para Receitas
                  _buildIconButton(Icons.lightbulb, "Dicas", _navegarParaDicas),
                  _buildIconButton(Icons.category, "Categorias", _navegarParaCategorias),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Últimas receitas pesquisadas:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _ultimasReceitas.isEmpty
                  ? Text("Nenhuma receita pesquisada ainda.")
                  : Column(
                children: _ultimasReceitas.map((receita) {
                  return ListTile(
                    title: Text(receita),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeReceita(receita),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SegundaTela(valor: receita),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                "Prévia da lista de compras:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 150,
                child: ListView.builder(
                  itemCount: listaDeCompras.length < 100 ? listaDeCompras.length : 100,
                  itemBuilder: (context, index) {
                    final item = listaDeCompras[index];
                    final bool isChecked = item['checked'] ?? false;

                    return Padding( // Adiciona espaço entre os itens
                      padding: EdgeInsets.only(bottom: 8.0), // Espaço entre os itens
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: isChecked ? Color(0xFF942B2B) : Colors.transparent,
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: isChecked
                                    ? Icon(Icons.check, size: 16, color: Colors.white)
                                    : null,
                              ),
                              SizedBox(width: 8),
                              Text(
                                item['nome'],
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            "(${item['quantidade']})",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              TextButton(
                child: Text("Ver Mais"),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red, // Cor de fundo
                  foregroundColor: Colors.white, // Cor do texto
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListaScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeReceita(String receita) {
    setState(() {
      _ultimasReceitas.remove(receita);
    });
  }
}
