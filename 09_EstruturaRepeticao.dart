main(){
  // Estrutura de repetição são iguais ao do C/C++

  print("== COM FOR ==");
  for(int i = 0; i < 10; i++){
    print("Rodou: $i vezes");
  }

  print("== COM WHILE ==");
  int i = 0;
  while(true){
    print("Rodou: $i vezes");
    i++;
    if(i == 10) break;
  }
}