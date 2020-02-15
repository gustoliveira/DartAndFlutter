import 'dart:io';

main() {
  print("== DIGITE SEU PESO ==");
  int peso = int.parse(
      stdin.readLineSync()); // É possível tipar a variável de maneira fixa

  print("== DIGITE SUA ALTURA ==");
  double altura = double.parse(stdin.readLineSync());

  double IMCcalc = calculaIMC(peso, altura);

  mostraResultado(IMCcalc);

  findVolume(10,
      height: 20, breadth: 5); // Sequence doesn't matter in Named Parameter

//Função anonima: o que está dentro das chaves após os parenteses, fica como a função botaoCriado();
  criarBotao("Botão De GPS", () {
    print('Botão Criado');
  });
}

double calculaIMC(int peso, double altura) {
  return peso / (altura * altura);
}

// Arrow Function, é equivalente a função anterior
double calculaIMC2(int peso, double altura) => peso / (altura * altura);

mostraResultado(double IMCcalc) {
  if (IMCcalc < 18.5) {
    print("Abaixo do peso");
  } else if (IMCcalc >= 18.5 && IMCcalc <= 24.9) {
    print("Peso normal");
  } else if (IMCcalc >= 25 && IMCcalc <= 29.9) {
    print("Sobrepeso");
  } else if (IMCcalc >= 30 && IMCcalc <= 34.9) {
    print("Obesidade grau 1");
  } else if (IMCcalc >= 35 && IMCcalc <= 39.9) {
    print("Obesidade grau 2");
  } else if (IMCcalc >= 40) {
    print("Obesidade grau 3");
  }
}

// Parametros que estão dentro de colchetes não são necessários para rodar o programa
void printCountries(String name1, [String name2, String name3]) {
  print("Name 1 is $name1");
  print("Name 2 is $name2");
  print("Name 3 is $name3");
}

// Parametros que estão dentro de chaves podem ser colocados sem ordem
// colocando seus nomes na frente
int findVolume(int length, {int breadth, int height}) {
  print("Length is $length");
  print("Breadth is $breadth");
  print("Height is $height");

  print("Volume is ${length * breadth * height}");

  return length * breadth * height;
}

// nome2 e nome3 já tem valores por padrão, mas que podem ser substituidos ao chamar a função
// ao colocar seus nomes normalmente, sem ordem
void test(String nome1, {String nome2 = "Foi", String nome3 = "Foizão"}) {
  print(nome1);
  print(nome2);
  print(nome3);
}

// FUNÇÃO RECEBENDO OUTRA FUNÇÃO COMO PARAMETRO
void botaoCriado() {
  print("Botão criado");
}

void criarBotao(String texto, Function botaoCriado) {
  print(texto);
  botaoCriado();
}
