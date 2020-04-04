// Superclasse, trata-se daquela que contem diversos atributos
// que vão ser herdados
class Localizacao {
  String rua, bairro;
  int numero;

  Localizacao({this.rua, this.numero});
}

// Subclasse, herda todos os elementos e métodos da superclasse
class Casa extends Localizacao{
  int qntsQuartos;
  bool quintal;

  Casa({this.qntsQuartos, this.quintal, rua, numero}): super(rua: rua, numero: numero);
}

// Assim como a classe Casa, Apartamento tb herda todos os atributos da Localização
class Apartamento extends Localizacao{
  int andar;
  bool varanda;

  Apartamento({this.andar, this.varanda, rua, numero}): super(rua: rua, numero: numero);
}

// FUNÇÃO PRINCIPAL
main(){
  Apartamento cidade = new Apartamento(rua: "Sei não", numero: 69, andar: 24, varanda: true);

  Casa praia = new Casa(rua: "Viuje", numero: 24, qntsQuartos: 5, quintal: false);

  print(praia.qntsQuartos);
  print(cidade.varanda);
}

/*
Herança é um conceito importante de POO pois com ele é possível
"segmentar" o código, deixar ele mais módular para não apenas
facilitar a leitura, mas também para facilitar a refatoração e testes
*/