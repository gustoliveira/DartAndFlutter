## O QUE FOI ESTUDADO NESTE APP

Importando material design (assim como qualquer biblioteca) e seu funcionamento simples: 'package:flutter/material.dart'
* Contem 'MaterialApp();' que serve para rodar nossa aplicação flutter com base no material
* Função 'runApp()' nós temos que passar um widget como parametro
* home: _parametro_ de Container, refere-se a homepage do aplicativo
    Nota-se que em flutter, até as telas são widgets


Widgets simples:
* Container: _widget_ que serve justamente para colocar outros widgets
* Column: _widget_ que possibilita organizar outros widgets na VERTICAL
* Row: _widget_ que possibilita organizar outros widgets na HORIZONTAL
* Padding: _widget_ que coloca outro widget dentro dele, mas com uma borda invisivel dos lados
* Stack: _widget_ para sobrepor outros widgets
    _children <Widget>:_ coloca os widgets nesse atributo, os que vem primeiro na ordem ficam em baixo


Como adicionar uma imagem:
* Cria uma pasta chamada images
* Coloca la suas imagens
* Vai em pubsped.yaml, cria um assets, e declara lá todas suas imagens


