## __O FOI ESTUDADO NESTE APP__

### __Cloud Firestore__

#### Fontes

[Cloud Firestore README Guide](https://pub.dev/packages/cloud_firestore)

#### Para importar
```{dart}
import 'package:cloud_firestore/cloud_firestore.dart';
```

#### Lógica do banco de dados
* Há coleções e documentos
* Documentos estão contidos em Coleções
* É possível criar subcoleções, inserindo-as dentro de documentos

#### Escrevendo no banco de dados

```{dart}
Firestore.instance.collection("col").document("txt").setData({"texto": "Guxtavo"});
```
* ```Firestore.instance``` irá chamar uma instancia no padrão singleton
* ```.collection(<NOME DA COLEÇÃO>).document(<NOME DO DOCUMENTO>)``` trata-se das referencias (localização)
* Para criar coleção dentro de um documento, é só colocar .collection depois de .document(): ```Firestore.instance.collection("col").document("txt").collection("foto").document("foto.jpeg")```
* Se não colocar o nome do document: ```.document()```, ele irá criar um id único automáticamente
* Para criar um document com id único também pode-se utilizar:
```
Firestore.instance.collection("messages").add({"texto": "Guxtavo"});
```
* Se o document e/ou collection especificado não houver ele irá criar, se existirem ele irá modificar
* ```.setData({JSON})``` irá escrever informações EM TODOS OS CAMPOS na localização dada pelas referencias
* ```.updateData({JSON})``` irá modificar as chaves especificadas no json, sem reescrever todo o objeto

#### Lendo banco de dados
Há duas maneiras de ler, uma "estática", que irá receber uma vez e nunca mais  e outra "dinâmica", que sempre que o objeto for atualizado ele irá retornar novamente atualizado.

* Irá retornar dentro do objeto snapshot, uma "foto", o estado fixo daquele momento de todos documentos da consulta:
```{dart}
QuerySnapshot snapshot = await Firestore.instance.collection('col').getDocuments();
snapshot.documents.forEach((f){
    print(f.data);
    print(f.documentID); Irá retornar o ID do documento
    f.reference.updateData({'lido': false}); // Atualizar campo
});
```
* Irá retornar dentro do objeto snapshot, toda as informações do documento especificado:
```{dart}
DocumentSnapshot snapshot = await Firestore.instance.collection('col').document('PwiXTeyzNTaz8LlcUVJx').get();
print(snapshot.data);
```

* Recebe o dado, e sempre que mudar algo no banco de dados, ele irá receber as mudanças e chamar a função:
```
Firestore.instance.collection('col').snapshots().listen((dado){
    dado.documents.forEach((f){
        print(f.data);
    });
});
```
* Irá retornar sempre que houver mudanças em algum documento em especifico
```
Firestore.instance.collection('col').document('PwiXTeyzNTaz8LlcUVJx').snapshots().listen((dado){
    print(dado.data);
});
```

### __Autenticação Google pelo Firebase__

#### Fonte

[Firebase Auth README guide](https://pub.dev/packages/firebase_auth)

É possível fazer autorização atráves de:
* Google
* Email e Senha
* Número de telefone
* Anonimamente
* GitHub
* Facebook
* Twitter

#### Para importar

```{dart}
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
```

#### Função para fazer login atráves da conta do Google

```
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> _handleSignIn() async {
  // Irá fazer a animação de logar atráves da conta Google
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  // Irá receber id e token para logar no Firebase
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Provider para conta Google
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken, // Token e Id fornecidos anteriormente
    idToken: googleAuth.idToken,
  );

  // Irá criar um usuário no Firebase
  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  return user;
}
```

### __SnackBar para Scaffold__

#### Primeira forma:
Crie a seguinte variável, ela será responsável por ser um "controlador" do Scaffold, em que uma de suas funções é chamar a SnackBar

```
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
```
No Scaffold, coloque a variável criada anteriormente como atributo key:
```
return Scaffold(
  key: _scaffoldKey,
)
```

Para mostrar é só chamar a seguinte função:

```
_scaffoldKey.currentState.showSnackBar(
  SnackBar(
    content: Text(<ALGUMA MENSAGEM>),
  )
);
```

#### Segunda forma:
```
// Criando um widget SnackBar
final snack = SnackBar(
    content: Text(<ALGUMA MENSAGEM>),
    // SnackBar com um botão que pode tomar uma ação
    action: SnackBarAction(
        label: "Desfazer",
        onPressed: (){
            setState(() {
                <ALGUMA AÇÃO>
            });
        },
    ),

// Chamando Scaffold e adicionando a snack bar que acabamos de criar
Scaffold.of(context).showSnackBar(snack);
```