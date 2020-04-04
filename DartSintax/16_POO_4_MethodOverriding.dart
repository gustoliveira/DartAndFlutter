class Animal {
  String especie;
  String cor = "Marrom";

  Animal({this.especie});

  void eat(){
    print("O animal está comendo");
  }
}

class Cachorro extends Animal {
  String raca;

  Cachorro({this.raca, especie}): super(especie: especie);

  String cor = "Preto"; // Property Overriding

  // Method Overriding
  void eat(){
    super.eat();
    print("Não o interrompa");
  }
}

/*
Method e Property Overriding trata-se da subclasse podendo
alterar os atributos e métodos da superclasse
*/