import 'package:flutter/material.dart';
import 'package:e_buscador_de_gifs/ui/home_page.dart';
import 'package:e_buscador_de_gifs/ui/gif_page.dart';

void main(){
  runApp(
    MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        hintColor: Colors.white,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme( // Cor da borda do TextField quando não estiver selecionada
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          )
        )
      ),
    )
  );
}