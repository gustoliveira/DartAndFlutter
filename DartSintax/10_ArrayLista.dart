import 'dart:io';

main(){
  var lista = []; // Declaração de uma lista

  for(int i = 0; i < 3; i++){
    var aux = stdin.readLineSync();
    lista.add(aux); //Adicionando um item a lista na ultima posição
  }
  print(lista); // Printa todo a lista

  print(lista.length); //Printa o tamanho da lista

  print(lista[0]); //Acessa a posição na lista da mesma maneira que no python e C/C++

  lista.add("Valor");

  lista.remove("Valor"); // Remove de acordo com a chave

  lista.removeAt(0); // Remove de acordo com a posição

  List<String> tipando; // Assim fixa a tipagem de uma lista
  tipando.add("Foi");
}