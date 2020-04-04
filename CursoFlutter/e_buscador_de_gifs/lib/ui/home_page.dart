import 'dart:convert';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:e_buscador_de_gifs/ui/gif_page.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search; // O que estamos querendo pesquisar
  int _offset = 0; // A partir de que ponto começa a fazer a pesquisa

  Future<Map> _getGifs() async {
    http.Response response; // Resposta da API do Giphy

    if(_search == null || _search.isEmpty){
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=kvkJg2JRNtaJX3vA7VnlgnjBsA7sM5me&limit=20&rating=G");
    }
    else {
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=kvkJg2JRNtaJX3vA7VnlgnjBsA7sM5me&q=$_search&limit=19&offset=$_offset&rating=G&lang=en");
    }

    return json.decode(response.body); // Decodificando o body da resposta, que contem um json
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network("https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
        centerTitle: true
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Search",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder()
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              ),
              onSubmitted: (text){
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return _searchingGIFsWatingNone();
                  default:
                    if(snapshot.hasError) {
                        return Container(
                          child: Text(
                            "Erro",
                            style: TextStyle(color: Colors.white),
                          ),
                          width: 200,
                          height: 200
                      );
                    }
                    else {
                      return _createGIFsTable(context, snapshot);
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget para mostrar que está carregando os GIFs
  Widget _searchingGIFsWatingNone(){
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 200,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  int _getCount(List data){
    if(_search == null)
      return data.length;
    else return data.length + 1;
  }

  Widget _createGIFsTable(BuildContext context, AsyncSnapshot snapshot){
    return GridView.builder( // Creates a scrollable, 2D array of widgets that are created on demand (MOSTRA EM FORMATO DE GRID)
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // Organizar widgets em grid
        crossAxisCount: 2, // Quantos widgets irão ser mostrados
        crossAxisSpacing: 10, // Espaço entre eles
        mainAxisSpacing: 10
      ),
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index){
        if(_search == null || index < snapshot.data["data"].length){
          return GestureDetector( // Permite que Widget seja clicavel para fazer alguma ação com ele
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300,
              fit: BoxFit.cover,
            ),
            onTap: (){ // Ao apertar apenas uma vez
              Navigator.push(context, // Chama a outra ui
                MaterialPageRoute(builder: (context) => GIFsPage(snapshot.data["data"][index]))
              );
            },
            onLongPress: (){ // Ao apertar longamente
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
            },
          );
        }
        else {
          return Container( // Para que carregue mais aplicativos
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    "Carregar mais...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22
                    ),
                  )
                ],
              ),
              onTap: (){
                setState(() {
                  _offset += 19;
                });
              },
            )
          );
        }
      },
    );
  }
}
