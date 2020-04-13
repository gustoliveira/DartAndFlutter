import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Plugin para conseguir conectar com o telefone para ligar

import 'contact_page.dart';
import 'package:f_agenda_de_contatos/helpers/contacte_helper.dart';

enum OrderOptions {orderaz, orderza}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = new ContactHelper();
  // Note que por ser um singleton, mesmo que eu chamasse novamente com outro nome seria
  // a mesma classe

  List<Contact> contacts = List();

  @override
  void initState() { // initState serve para fazer alguma ação quando a classe for chamada
    super.initState();

    // Quando inicia o app, ele já busca todos os contatos para construir a tela
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de A-Z"),
                value: OrderOptions.orderaz,
              ),
              const PopupMenuItem<OrderOptions>(
                child: Text("Ordenar de Z-A"),
                value: OrderOptions.orderza,
              )
            ],
            onSelected: _orderList,
          )
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contacts.length, // Necessita pois, o ListView.builder funciona em um loop que dura o itemCount, e cada vez que roda, ele constrói um dos itens
        itemBuilder: (context, index){
          return _contactCard(context, index);
        }
      ),
    );
  }

  void _showOptions(context, index){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return BottomSheet(
          onClosing: (){},
          builder: (context){
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                      child: Text(
                        "Ligar",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20
                        ),
                      ),
                      onPressed: (){
                        launch("tel:${contacts[index].phone}");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                      child: Text(
                        "Editar",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20
                        ),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                        _showContactPage(contact: contacts[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                      child: Text(
                        "Excluir",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20
                        ),
                      ),
                      onPressed: (){
                        helper.deleteContact(contacts[index].id);
                        setState(() {
                          contacts.removeAt(index);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  )
                ],
              ),
            );
          },
        );
      }
    );
  }

  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(
      onTap: (){
        _showOptions(context, index);
      },
      child: Card( // Card são só as bordas, que são levemente arredondadas e com uma sombra, não tem nada relacionado com as informações no interior
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration( // Para que a imagem fique dentro de um circulo
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ? // Caso tenha uma imagem, coloque-a do path, caso contrário, coloque a imagem padrão dos assets
                      FileImage(File(contacts[index].img)) :
                      AssetImage("images/person.png")
                  )
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10), // Padding para ter uma separação da imagem
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Irá dispor todas as informações a partir do começo do widget
                  children: <Widget>[
                    Text(
                      contacts[index].name ?? "",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                    Text(
                      contacts[index].email ?? "",
                      style: TextStyle(fontSize: 11),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                    Text(
                      contacts[index].phone ?? "",
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getAllContacts(){
    helper.getAllContacts().then((list){
    setState(() {
      contacts = list;
      });
    });
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage(contact: contact)));
    // Navigator também retorna informações mandadas por outras paginas, no caso deste app, atráves da função pop que está
    // na contact_page

    if(recContact != null){ // Se recContact retornar algo
      if(contact != null){ // Se o contato for diferente de nulo, signifca que foi uma atualização de um contato existente
        await helper.updateContact(recContact);
        _getAllContacts();
      }
      else { //  Se for nulo, significa que é um contato criado, então ele cria um novo contato no banco de dados
        await helper.saveContact(recContact);
        _getAllContacts();
      }
    }
  }

  void _orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderaz:
        contacts.sort((a, b){
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        contacts.sort((a, b){
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }
    setState(() {});
  }
}