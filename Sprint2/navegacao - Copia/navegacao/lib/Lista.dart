import 'package:flutter/material.dart';
import 'main.dart'; // Importar o arquivo principal para acessar a lista global

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _listaNomeController = TextEditingController(text: "Lista de Compras");
  bool _isEditMode = false;
  Color _listaColor = Colors.pink[200]!; // Cor inicial da lista

  // Lista de cores disponíveis para escolher
  final List<Color> coresDisponiveis = [
    Colors.pink[200]!,
    Colors.blue[200]!,
    Colors.green[200]!,
    Colors.purple[200]!,
    Colors.orange[200]!,
  ];

  void _adicionarItem() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        listaDeCompras.add({'nome': _controller.text, 'marcado': false, 'quantidade': 1});
        _controller.clear();
      }
    });
  }

  void _atualizarQuantidade(int index, int delta) {
    setState(() {
      listaDeCompras[index]['quantidade'] = (listaDeCompras[index]['quantidade'] + delta).clamp(1, 99);
    });
  }

  void _removerItem(int index) {
    setState(() {
      listaDeCompras.removeAt(index);
    });
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.shopping_cart, color: Colors.black), // Ícone de carrinho de supermercado
            SizedBox(width: 10),
            Text(
              "Lista de Compras",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Nome editável da lista
            Container(
              decoration: BoxDecoration(
                color: _listaColor, // Usar a cor escolhida
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Center(
                child: TextField(
                  controller: _listaNomeController,
                  decoration: InputDecoration(
                    hintText: 'Digite o nome da lista',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 16),
            // Seletor de cores para a lista
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: coresDisponiveis.map((cor) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _listaColor = cor; // Atualiza a cor da lista
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: cor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            if (_isEditMode)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Novo item',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _adicionarItem,
                  ),
                ],
              ),
            Expanded(
              child: ListView.builder(
                itemCount: listaDeCompras.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      leading: Checkbox(
                        value: listaDeCompras[index]['marcado'],
                        onChanged: (bool? valor) {
                          setState(() {
                            listaDeCompras[index]['marcado'] = valor!;
                          });
                        },
                      ),
                      title: Text(
                        listaDeCompras[index]['nome'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Container(
                        width: 120, // Ajuste de largura para caber os botões e o número
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                _atualizarQuantidade(index, -1);
                              },
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6), // Ajustado para dar mais espaço
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Text(
                                listaDeCompras[index]['quantidade'].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                _atualizarQuantidade(index, 1);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text("SALVAR"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    for (var item in listaDeCompras) {
                      print("${item['nome']}: ${item['marcado'] ? 'Marcado' : 'Desmarcado'} | Quantidade: ${item['quantidade']}");
                    }
                  },
                ),
                ElevatedButton(
                  child: Text("EDITAR"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _toggleEditMode,
                ),
                ElevatedButton(
                  child: Text("EXCLUIR"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      listaDeCompras.removeWhere((item) => item['marcado']);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
