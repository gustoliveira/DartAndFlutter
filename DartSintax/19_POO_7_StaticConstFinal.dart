class Constantes {
  static int qntCliques; // atributo será da classe, não do objeto

}

main() {
  Constantes.qntCliques =
      19; // Com static eu posso acessar sem precisar instanciar um objeto

  const numero = 3; // Constante em tempo de compilação
// NÃO PODE usar 'const' em estruturas condicionais, pois na compilação não se sabe seu valor

  final teste = 4; // Constante em tempo de execução
}
