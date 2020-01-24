abstract class Animal {
  String raca, nome;
  double peso, tamanho;

  Animal({this.nome, this.raca, this.peso, this.tamanho});

  void comer();

  void fazerSom();
}

class Gato extends Animal {
  Gato({nome, raca, peso, tamanho}): super(nome: nome, raca: raca, peso: peso, tamanho: tamanho);

  void comer(){
    print('O gato está comendo');
  }

  void fazerSom(){
    print('Miau');
  }
}

class Cachorro extends Animal {
  Cachorro({nome, raca, peso, tamanho}): super(nome: nome, raca: raca, peso: peso, tamanho: tamanho);

  void comer(){
    print('O cachorro está comendo');
  }

  void fazerSom(){
    print('auau');
  }
}

main(){
  // Animal animal = Animal(...) -> Isto não pode ser feito

  Gato cat = Gato(nome: 'Pantera', peso: 15, tamanho: 30, raca: 'Britsh Shorthair');
  cat.comer();
  cat.fazerSom();

  Cachorro dog = Cachorro(nome: 'Doguera', peso: 20, tamanho: 50, raca: 'Dachshund');
  dog.comer();
  dog.fazerSom();
}

/*
Classes abstratas não podem ser instanciadas, apenas servem como superclasses

Pode-se também criar métodos sem corpo, porém, todos as subclasses devem obrigatoriamente
declarar um corpo para tais métodos

Classes abstratas então servem como rascunho, contem métodos e atributos que são irão servir
como base para todas suas subclasses.

No exemplo acima, por exemplo, é desnecessário ter uma classe animal, porém, ela serve como base
para duas outras classes que são úteis, no caso a classe a Gato e Cachorro

Isto serve para modularizar mais código e facilitar a refaturação do código
*/