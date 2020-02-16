import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController controladorPeso = TextEditingController();
  TextEditingController controladorAlt = TextEditingController();

  String _infoText = "Informe seu Peso e Altura";

  void _resetFields() {
    controladorAlt.text = "";
    controladorPeso.text = "";
    setState(() {
      _infoText = "Informe seu Peso e Altura";
    });
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(controladorPeso.text);
      double altura = double.parse(controladorAlt.text) / 100;

      double calcIMC = peso / (altura * altura);

      _infoText = "IMC: ${calcIMC.toStringAsPrecision(4)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          backgroundColor: Colors.green,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              iconSize: 40,
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                      controller: controladorPeso,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso (kg)",
                          labelStyle:
                              TextStyle(color: Colors.green, fontSize: 20)),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                      validator: (value) {
                        return value.isEmpty ? "Insira seu peso" : null;
                      },
                  ),
                  TextFormField(
                      controller: controladorAlt,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura (cm)",
                          labelStyle:
                              TextStyle(color: Colors.green, fontSize: 20)),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                      validator: (value) {
                         return value.isEmpty ? "Insira sua altura" : null;
                      },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if(_formKey.currentState.validate()) _calculate();
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("$_infoText",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center)),
                ],
              ),
            )));
  }
}
