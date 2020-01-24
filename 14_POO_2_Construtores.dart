import 'POO/animal.dart';

class Pessoa {
  String nome, sobrenome, sexo;
  int idade;

  // Construtor da classe
  Pessoa(String nome, String sobrenome, String sexo, int idade){
    this.nome = nome;
    this.sobrenome = sobrenome;
    this.sexo = sexo;
    this.idade = idade;
  }

  // Arrow function: quando apenas uma instrução, pode se fazer desta forma
  String nomeCompleto() => nome + ' ' + sobrenome;
}

class Animal {
  String especie;
  int peso, tamanho;

  // Assim como nas funções, colocar entre chaves,
  // possibilita especificar na hora de instanciar,
  // o que permite construir com as váriáveis fora de ordem
  Animal({String especie, int peso, int tamanho}){
    this.especie = especie;
    this.peso = peso;
    this.tamanho = tamanho;
  }
}

class Casa {
  String rua;
  int numero, qntQuartos;

  // Para facilitar ao máximo, há essa sintaxe no Dart
  // Chama-se construtor inteligente
  Casa({this.rua, this.numero, this.qntQuartos});

}

main(){
  Pessoa pessoa = Pessoa("Gustavo", "de Oliveira Ferreira", "M", 18);
  print(pessoa.nomeCompleto());

  Animal animal = Animal(especie: "Cachoro", peso: 10, tamanho: 100);

  Casa casa = Casa(rua: "Barão de Jeremoabo", numero: 69, qntQuartos: 0);

}