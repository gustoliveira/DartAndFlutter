import 'package:path/path.dart';
import 'dart:async';

import 'package:sqflite/sqflite.dart'; // Pensar o banco de dados como uma tabela, onde cada atributo
// fica nas colunas e cada dado é uma das linhas
// https://pub.dev/packages/sqflite DOCUMENTAÇÃO EXPLICADA COM EXEMPLOS COMPREENSÍVEIS


// Nome das colunas
final String contactTable = "contactTable"; // Nome da tabela
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";

// PADRÃO SINGLETON: Utilizado quando se quer ter apenas um objeto instanciado de uma classe
// https://pt.stackoverflow.com/questions/377268/sobre-singleton-pattern-em-dart-como-entender-essa-estrutura
class ContactHelper {
  ContactHelper.internal(); // Constrói a classe internamente
  // .internal() trata-se de um construtor normal, só que é construido dentro da classe, e não quando ela for chamada

  static final ContactHelper _instance = ContactHelper.internal(); // Instancia o objeto único da classe
  // static: _instance é da classe, não ao objeto
  // final: _instance é intalterável, garantindo a propriedade do padrão Singleton

  factory ContactHelper() => _instance; // Construtor que sempre retorna a instancia já criada
  // factory é utilizado quando nem sempre se cria uma nova instancia da classe, podendo retornar uma instancia já existente
  // ou seja, sempre retornando _instace quando a classe for chamada

  // BANCO DE DADOS
  Database _db; // Instanciando banco de dados
  // com _ para que apenas esta classe possa acessar o valor em sua integralidade

  // Usando get para que seja possível utilizar esta função fora da classe
  Future<Database> get db async {
    if(_db != null){
      return _db;
    }
    else{
      _db = await initDb();
      return _db;
    }
  }

  // Inicializando banco de dados
  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath(); // Local que o banco de dados se encontra, que o plugin SQFlite gera
    final path = join(databasePath, "contactsnew.db"); // Arquivo que irá pegar o banco de dados

    // Criando banco de dados
    return openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)"
      ); // Pediu para criar a tabela com tal nome, e com as colunas que estão dentro dos parenteses
    });
  }

  //Funções para manipular os contatos
  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;

    //https://stackoverflow.com/questions/54223929/how-to-do-a-database-query-with-sqflite-in-flutter
    List<Map> maps = await dbContact.query( // Fazendo uma query na tabela
      contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn], // Retornando todas essas colunas
      where: "$idColumn = ?", // Procurando na idColumn
      whereArgs: [id] // O '?' no where será substituido por todos os parametros na lista whereArgs
    );

    if(maps.length > 0){
      return Contact.fromMap(maps.first);
    }
    else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact.delete(
      contactTable,
      where: "$idColumn = ?",
      whereArgs: [id]
    ); // a função .delete retorna um inteiro mostrando se deu certo ou não
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(
      contactTable,
      contact.toMap(),
      where: "$idColumn = ?",
      whereArgs: [contact.id]
    );
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List<Map> listMap = await dbContact.rawQuery("SELECT * FROM $contactTable"); // Consulta toda o db e retorna uma lista com os contatos em Map

    // Transforma todos os Maps de listMap em Contact, adicona em uma lista e retorna-a
    List<Contact> listContact = List();
    for(Map i in listMap){
      listContact.add(Contact.fromMap(i));
    }
    return listContact;
  }

  // Retorna a quantidade de elementos na tabela
  Future<int> numberContacts() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery('SELECT COUNT(*) FROM $contactTable'));
  }

  closeDb() async {
    Database dbContact = await db;
    await dbContact.close();
  }

}

class Contact {
  int id; // id único para cada usuário
  String name;
  String email;
  String phone;
  String img; // Como não tem como guardar imagens no banco de dados, guarda-se o path para a imagem

  Contact(); // Construtor

  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }
  // "Cria" uma nova referencia para o mesmo contato
  // fromMap pois vamos armazenar os dados em formato de mapa no banco de dados, quando formos recuperar
  // precisamos transformar para o formato normal novamente

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    if(id != null){ // O id será definido pelo db, ele pode ou não ser nulo, então definimos assim
      map[idColumn] = id;
    }
    return map;
  }

  // Retorna uma representação em String do objeto Contact
  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }

}