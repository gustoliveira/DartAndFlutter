import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _toDoController = TextEditingController(); // Controller para o TextField que recebe a nova tarefa

  List _toDoList = []; // Lista que contem todas as tarefas
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPosition;

  // Override está função sempre que quiser inicializar o aplicativo com algum tipo de informação
  @override
  void initState(){
    super.initState();

    _readData().then((data){
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  // Função para adicionar tarefa a lista
  // Como a função irá atualizar a lista, faz um setState, para poder criar um novo no CheckedListView
  void _addToDo(){
    setState(() {
    Map<String, dynamic> newToDo = {
      "title": _toDoController.text,
      "ok": false
    };
    _toDoController.text = "";
    _toDoList.add(newToDo);

    _saveData(); // Salva novamente a lista
    });
  }

  Future<Null> _refreshList() async {
    await Future.delayed(Duration(microseconds: 500)); // Força ele esperar um tempo para poder atualizar

    setState(() {
        _toDoList.sort((a, b) { // Função para ordenar a lista, olhando dois parametros
        if(a["ok"] && !b["ok"]) return 1;
        else if(!a["ok"] && b["ok"]) return -1;
        else return 0;

        _saveData(); // Para que salve a ordem
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDo List",
          style: TextStyle(fontWeight: FontWeight.bold),
          ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        brightness: Brightness.light,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
            children: <Widget>[
              Expanded( // Expanded para que o TextField ocupe o maior espaço possível, deixando ele grande
                child: TextField( // e o botão pequeno
                  controller: _toDoController,
                  decoration: InputDecoration(
                    labelText: "Nova Tarefa",
                    labelStyle: TextStyle(color: Colors.blue)
                    ),
                  ),
                ),
              RaisedButton(
                color: Colors.blue,
                child: Text("ADD"),
                textColor: Colors.white,
                onPressed: (){
                  if(_toDoController.text != "") { // Só adiciona uma tarefa se houver um texto
                    _addToDo();
                  }
                },
                )
              ],
            )
          ),
          Expanded( // Mesma ideia da Row, para que a ListView ocupe todo o espaço da tela
            child: RefreshIndicator(
              onRefresh: _refreshList, // Ordenar a lista, os que estão marcados vão para baixo
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: _toDoList.length,
                itemBuilder: _buildCheckboxListTile
              )
            )
            )
        ],
      ),
    );
  }

  // Função para pegar o arquivo que conterá todas as tarefas no diretório do celular
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory(); // Facilita achar o diretório no Android/iOS
    return File("${directory.path}/data.json"); // Retornando o path para o diretório e "cria" um arquivo .json
  }

  // Função para salvar os dados no arquivo data.json
  Future<File> _saveData() async {
    String data = json.encode(_toDoList); // Transforma a lista em json
    final file = await _getFile(); // Pega o arquivo que contem todas as tarefas, no caso, data.json, para salvar lá
    return file.writeAsString(data); // Salva a lista "data" no File com path "file"
  }

  Future<String> _readData() async{
    try {
       final file = await _getFile(); // Pega o path do arquivo que contem todas as tarefas
       return file.readAsString(); // Tenta ler o arquivo como uma String
    }
    catch (e) {
      return null; // Se não conseguir ler o arquivo como uma String, retorna NULL
    }
  }

  Widget _buildCheckboxListTile (BuildContext context, int index){ // index é o elemento da _toDoList que ele irá desenhar no momento
    return Dismissible( // Widget que possibilita deslizar itens
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()), // Necessita de uma key, que uma string única para cada widget que ele está deslizando
      child: CheckboxListTile( // child é o item que ele irá deslizar
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(
            _toDoList[index]["ok"] ? Icons.check : Icons.error // Se estiver ok muda o ícone
            ),
        ),
        onChanged: (bool _madeTask) {
          setState(() {
            _toDoList[index]["ok"] = _madeTask; // Se apertar o checked, muda o "ok" no json
            _saveData(); // Para atualizar a lista, mostrando que agora ela está true na memória
          });
        },
      ),
      background: Container( // O que vai ficar atrás do widget quando deslizar
        color: Colors.red,
        child: Align( // Para que o icone que está no container fique perto da borda quando ele deslizar
          alignment: Alignment(-0.9, 0),
          child: Icon(
          Icons.delete,
          color: Colors.white
        ),)
      ),
      direction: DismissDirection.startToEnd, // O movimento para deslizar é da esquerda para direita
      onDismissed: (direction){ // direction pode ser EndToStart tb, assim, podemos tomar diferentes ações a depender da direção que o usuário mover
        setState(() {
        _lastRemoved = Map.from(_toDoList[index]);
        _lastRemovedPosition = index;
        _toDoList.removeAt(index);

        _saveData(); // Salvando a remoção

        // SNACKBAR
        // Cria uma snack bar (mensagem) quando remover algum item
        final snack = SnackBar(
          content: Text("\"${_lastRemoved["title"]}\" foi removido! "),
          action: SnackBarAction( // Ação de desfazer, reinserir o ítem
            label: "Desfazer",
            onPressed: (){
              setState(() {
                _toDoList.insert(_lastRemovedPosition, _lastRemoved);
                _saveData();
              });
            },
          ),
          duration: Duration(seconds: 2) // Duração do tempo possível de adicionar novamente
        );

        Scaffold.of(context).showSnackBar(snack); // Chamando Scaffold e adicionando a snack bar que acabamos de criar
        });
      },
    );
  }
}
