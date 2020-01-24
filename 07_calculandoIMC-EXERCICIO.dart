import 'dart:io';

main(){
  var peso;
  var altura;

  print("== DIGITE SEU PESO ==");
  peso = int.parse(stdin.readLineSync());

  print("== DIGITE SUA ALTURA ==");
  altura = double.parse(stdin.readLineSync());

  var IMCcalc = peso / (altura * altura);

  print("Seu IMC é: $IMCcalc");

  if(IMCcalc < 18.5){
    print("Abaixo do peso");
  }
  else if(IMCcalc >= 18.5 && IMCcalc <= 24.9){
    print("Peso normal");
  }
  else if(IMCcalc >= 25 && IMCcalc <= 29.9){
    print("Sobrepeso");
  }
  else if(IMCcalc >= 30 && IMCcalc <= 34.9){
    print("Obesidade grau 1");
  }
  else if(IMCcalc >= 35 && IMCcalc <= 39.9){
    print("Obesidade grau 2");
  }
  else if(IMCcalc >= 40){
    print("Obesidade grau 3");
  }

}