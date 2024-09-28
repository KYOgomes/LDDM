import 'dart:io';  // Para trabalhar com o File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';  // Pacote para pegar imagem

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  String nome = "Caio Gomes";
  String email = "caioga2011@gmail.com";
  String receitasPublicadas = "7";
  String categoriaPreferida = "Doces";
  File? _image;  // Variável para armazenar a imagem escolhida
  final picker = ImagePicker();  // Instância do ImagePicker

  // Função para abrir diálogo de edição de texto
  Future<void> _editarCampo(String campo, String valorAtual, Function(String) onSave) async {
    TextEditingController _controller = TextEditingController(text: valorAtual);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar $campo'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Novo $campo",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Cor do botão vermelho
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                onSave(_controller.text);
                Navigator.of(context).pop();
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  // Função para pegar imagem da galeria ou câmera
  Future<void> _escolherImagem(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto de perfil
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: _image != null
                        ? FileImage(_image!)  // Mostra a imagem selecionada
                        : AssetImage('assets/profile_placeholder.png')
                    as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: PopupMenuButton<ImageSource>(
                      icon: Icon(Icons.camera_alt, color: Colors.blue),
                      onSelected: (ImageSource source) {
                        _escolherImagem(source);  // Função para escolher imagem
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<ImageSource>>[
                        const PopupMenuItem<ImageSource>(
                          value: ImageSource.gallery,
                          child: Text('Selecionar da Galeria'),
                        ),
                        const PopupMenuItem<ImageSource>(
                          value: ImageSource.camera,
                          child: Text('Tirar Foto'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Campo para Nome
            ListTile(
              title: Text("Nome"),
              subtitle: Text(nome),
              trailing: Icon(Icons.edit),
              onTap: () {
                _editarCampo("Nome", nome, (novoNome) {
                  setState(() {
                    nome = novoNome;
                  });
                });
              },
            ),

            // Campo para Email
            ListTile(
              title: Text("Email"),
              subtitle: Text(email),
              trailing: Icon(Icons.edit),
              onTap: () {
                _editarCampo("Email", email, (novoEmail) {
                  setState(() {
                    email = novoEmail;
                  });
                });
              },
            ),

            Divider(),
            SizedBox(height: 10),
            Text(
              "INFORMAÇÕES PROFISSIONAIS",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            // Número de Receitas Publicadas
            ListTile(
              title: Text("Número de Receitas Publicadas"),
              subtitle: Text(receitasPublicadas),
            ),
            // Categoria Preferida
            ListTile(
              title: Text("Categoria Preferida"),
              subtitle: Text(categoriaPreferida),
              trailing: Icon(Icons.edit),
              onTap: () {
                _editarCampo("Categoria Preferida", categoriaPreferida, (novaCategoria) {
                  setState(() {
                    categoriaPreferida = novaCategoria;
                  });
                });
              },
            ),

            SizedBox(height: 30),

            // Botão para Fazer Cadastro
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Cor do botão vermelho
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Função para fazer cadastro
                },
                child: Text("Fazer cadastro"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
