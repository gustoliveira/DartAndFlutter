class Pessoa {
  String nome;
  int _idade; // Coloca-se o '_' na frente, é uma convenção que fala para não utilizar fora da classe
  double peso, _altura;

  Pessoa(this.nome, this._idade, this.peso, this._altura);

  Pessoa.nasceu(this.nome, this.peso, this._altura) {
    this._idade = 0;
  }

  void dormir() {
    print("$nome está dormindo");
  }

  void niver() {
    _idade++;
  }

  void calcIMC() {
    print(peso / (_altura * _altura));
  }

// Get serve para ler inicialmente o valor de uma atributo ou retornar para o main o atributo
  int get idade {
    return _idade;
  }

  double get altura {
    return _altura;
  }

// Set serve para alterar o valor de um atributo de acordo com algum parametro
  set altura(double altura) {
    if (altura >= 0.0 && altura <= 3.0) {
      _altura = altura;
    }
  }
}

main() {
  Pessoa pessoa1 = new Pessoa('Gustavo', 18, 70.6, 1.81);

  pessoa1
      .niver(); // Unico metodo que pode alterar a idade da pessoa, logo este atributo está protegido
  print(pessoa1.idade);

  pessoa1.altura = 1.82;
  pessoa1.altura = 15;
  print(pessoa1.altura);
}
