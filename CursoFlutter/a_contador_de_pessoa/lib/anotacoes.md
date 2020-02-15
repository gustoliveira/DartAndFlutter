função 'runApp()' nós temos que passar um widget como parametro

'package:flutter/material.dart'
    Contem 'MaterialApp();' que serve para rodar nossa aplicação flutter com base no material

Container: _widget_ que serve justamente para colocar outros widgets

home: _parametro_ de Container, refere-se a homepage do aplicativo
    Nota-se que em flutter, até as telas são widgets

Column: _widget_ que possibilita organizar outros widgets na VERTICAL

Row: _widget_ que possibilita organizar outros widgets na HORIZONTAL

'children: <Widget>[]': _parametro_ de Row e Column para colocar vários widgets

'mainAxisAlignment': parametro para localizar algum widget de acordo com o seu eixo principal
    Row: eixo principal é na Horizontal
    Column: eixo principal é na Vertical

Padding: _widget_ que coloca outro widget dentro dele, mas com uma borda invisivel dos lados
    _child_ coloca o outro widget dentro do child

Stack: _widget_ para sobrepor outros widgets
    _children <Widget>:_ coloca os widgets nesse atributo, os que vem primeiro na ordem ficam em baixo

Para adicionar uma imagem:
    1: Cria uma pasta chamada images
    2: Coloca la suas imagens
    3: Vai em pubsped.yaml, cria um assets, e declara lá todas suas imagens
