main(){
  if(1==1){
    print("É obvio que é verdadeiro uai");
  }
  else{
    print("Não vai sai isso aqui huahauha");
  }

  var num1 = 5;
  var num2 = 10;

  if(num1 > num2){
    print("$num1 é maior que $num2");
  }
  else if(num1 < num2){
    print("$num2 é maior que $num1");
  }
  else{
    print("$num1 é igual ao $num2");
  }

/*
condition ? expr1 : expr2
If condition is true, evaluates expr1 (and returns its value);
otherwise, evaluates and returns the value of expr2.
*/
  var teste = 1==2 ? "1 é igual a 2" : "1 é diferente de dois";
  print(teste);
}