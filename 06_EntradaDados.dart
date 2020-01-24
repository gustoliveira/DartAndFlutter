import 'dart:io'; // Biblioteca contendo funções de entrada e saída

main(){
  var input = stdin.readLineSync(); // Função para ler uma linha do terminal
  print(input);

  var entrada = stdin.readLineSync(); // Ela retorna sempre como uma string
  var number = int.parse(entrada); // Deste modo transforma em inteiro
  print(number);

  var teste = int.parse(stdin.readLineSync()); // Pode ser feito desta maneira também
  print(teste + 5);

}