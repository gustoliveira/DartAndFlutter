class Pessoa{
  // Variáveis são os atributos
  String nome;
  String sobrenome;
  String sexo;
  int idade;

  // Funções são os métodos
  String nomeCompleto(){
    return nome + ' ' + sobrenome;
  }
}

main(){
  Pessoa pessoa = new Pessoa(); // Instaciar -> cria a classe

  pessoa.nome = "Gustavo";
  pessoa.sobrenome = "de Oliveira Ferreira";
  pessoa.sexo = "masculino";
  pessoa.idade = 18;

  print(pessoa.nomeCompleto());
}