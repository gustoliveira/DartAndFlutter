import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class TextComposer extends StatefulWidget {
  // Serão responsáveis por receber as mensagens como parametro para poder enviar para chat_screen.dart e esse
  // arquivo por sua vez, enviar para o banco de dados.
  TextComposer(this.sendMessage);
  final Function({String text, File imgFile}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  bool _isComposing = false; // _isComposing é para saber se há algo escrito no TextField

  final TextEditingController _controller = TextEditingController();

  void _reset(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      // padding: const EdgeInsets.fromLTRB(8, 0, 8, 0), // é o mesmo que o de cima
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () async {
              final File imgFile = await ImagePicker.pickImage(source: ImageSource.camera);
              if(imgFile == null) return;
              widget.sendMessage(imgFile: imgFile);
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration.collapsed(hintText: "Enviar uma mensagem"), // .collapsed não irá colocar uma barrinha em baixo do TextField
              onChanged: (text){
                setState(() {
                  _isComposing = text.isNotEmpty; // Se o TextField não estiver vazio, então retorna true
                });
              },
              onSubmitted: (text){
                widget.sendMessage(text: text);
                _reset();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing ? (){ // Operador ternário: Se _isComposing for true (tem algo escrito), irá habilitar o IconButton, se for false, irá deixar desabilitado
              widget.sendMessage(text: _controller.text);
              _reset();
            } : null
          )
        ],
      ),
    );
  }
}