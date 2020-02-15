class Casa {
  String rua;
  int numero, qntQuartos;

  // Construtor da classe
  Casa(String rua, int numero, int qntQuartos) {
    this.rua = rua;
    this.numero = numero;
    this.qntQuartos = qntQuartos;
  }
}

class Animal {
  String especie;
  int peso, tamanho;

  // Assim como nas funções, colocar entre chaves,
  // possibilita especificar na hora de instanciar,
  // o que permite construir com as váriáveis fora de ordem
  Animal({String especie, int peso, int tamanho}) {
    this.especie = especie;
    this.peso = peso;
    this.tamanho = tamanho;
  }
}

class Pessoa {
  String nome, sobrenome, sexo;
  int idade;

  // Para facilitar ao máximo, há essa sintaxe no Dart
  // Chama-se construtor inteligente
  Pessoa({this.nome, this.sobrenome, this.sexo, this.idade});

  // Named constructor: outra maneira de declarar
  Pessoa.nasceu({this.nome, this.sobrenome, this.sexo}) {
    idade = 0;
    print(nomeCompleto());
  }

  // Arrow function: quando apenas uma instrução, pode se fazer desta forma
  String nomeCompleto() => nome + ' ' + sobrenome;
}

main() {
  Casa casa = Casa("Barão de Jeremoabo", 69, 0);
  print(casa.numero);

  Animal animal = Animal(especie: "Cachoro", peso: 10, tamanho: 100);
  print(animal.especie);

  Pessoa pessoa = Pessoa(
      nome: "Gustavo", sobrenome: "de Oliveira Ferreira", sexo: "M", idade: 18);
  print(pessoa.nomeCompleto());

  Pessoa nene = Pessoa.nasceu(
      nome: "Gustavo", sobrenome: "de Oliveira Ferreira", sexo: "M");
  print(nene.idade);
}
