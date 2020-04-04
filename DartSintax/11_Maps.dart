main(){

  // É como um JSON ou dict (python), serve para demonstrar dados
  // Associa cada valor a uma chave
  var maps = {
    'nome': 'Gustavo',
    'sobrenome': 'de Oliveira',
    'idade': 18,
    'nascimento': 'São Paulo-SP',
  };

  print(maps['nome']);

  maps['nome'] = 'de Oliveira Ferreira'; // Mudar o valor de uma determinada key

  // Tipagem de um map
  //String é o tipo da key e dynamic é o tipo do valor
  //DYNAMIC é um tipo o qual aceita qualquer outro tipo, como se fosse void
  Map<String, dynamic> maps1 = {
    'nome': 'Gustavo',
    'sobrenome': 'de Oliveira Ferreira',
    'idade': 18,
    'nascimento': 'São Paulo-SP',
  };
  print(maps1);

}