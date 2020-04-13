import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Plugin para ir para camera e galeria

import 'package:f_agenda_de_contatos/helpers/contacte_helper.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});
  // Página será utilizada tanto para criar um novo contato, quando para editar, por isso é opcional

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editedContact;

  bool _userEdited = false;

  final _nameFocus = FocusNode();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editedContact = new Contact();
    }
    else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
      // Transforma em map o contato passado, e depois cria um novo contato
      // Está "duplicando" o contato passado

      // Coloca as informações já existentes no TextFields atráves dos controles
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope( // Widget para facilitar exbir AlertDialog ao se fazer pop
      onWillPop: _requestPop, // Quando ele faz pop, ele chama a função
      child: Scaffold(
        appBar: AppBar(
          title: Text(_editedContact.name ?? "Novo Contato"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(_editedContact.name != null && _editedContact.name.isNotEmpty) {
              Navigator.pop(context, _editedContact); // Navigator funciona como uma pilha, .pop faz voltar para a página anterior
              // .pop também retorna algo para o navigator
            }
            else {
              FocusScope.of(context).requestFocus(_nameFocus); // Se for nulo ou tiver vazio o campo do nome, ele coloca o foco lá
            }
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.save),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  ImagePicker.pickImage(source: ImageSource.gallery).then((file){
                    if(file == null){
                      return;
                    }
                    else {
                      setState(() {
                        _editedContact.img = file.path;
                      });
                    }
                  });
                },
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration( // Para que a imagem fique dentro de um circulo
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _editedContact.img != null ? // Caso tenha uma imagem, coloque-a do path, caso contrário, coloque a imagem padrão dos assets
                        FileImage(File(_editedContact.img)) :
                        AssetImage("images/person.png")
                    )
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Nome"),
                onChanged: (text){
                  _userEdited = true;
                  setState(() {
                    _editedContact.name = text;
                  });
                },
                controller: _nameController,
                focusNode: _nameFocus,
              ),
              TextField(
                decoration: InputDecoration(labelText: "E-mail"),
                onChanged: (text){
                  _userEdited = true;
                    _editedContact.email = text;
                },
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Phone"),
                onChanged: (text){
                  _userEdited = true;
                    _editedContact.phone = text;
                },
                keyboardType: TextInputType.phone,
                controller: _phoneController,
              )
            ],
          )
        ),
      ),
    );
  }

  // Função para exibir AlertDialog
  Future<bool> _requestPop(){
    if(_userEdited){
      showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Descartar Alterações?"),
            content: Text("Se sair as alterações serão perdidas."),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Sim"),
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
      );
      return Future.value(false); // Não faz o pop de maneira automática
    }
    else {
      return Future.value(true); // Significa que o usuário não editou o contato, logo ele faz o pop automático
    }
  }
}