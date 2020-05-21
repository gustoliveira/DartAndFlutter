import 'text_composer.dart';
import 'chat_message.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser _currentUser;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.onAuthStateChanged.listen((user){ // Uma stream que sempre que o usuário for mudado, ele irá alterar no _currentUser
      setState(() {
        _currentUser = user;
      });
    });
  }

  Future<FirebaseUser> _getUser() async {
    if(_currentUser != null) return _currentUser; // Se houver um _currentUser, significa que já está logado
    // Se for null, ele faz o login:
    try {
      // Isso faz login com a conta do google e retorna conta do google do usuário
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn(); // Começa o processo interativo de autenticação

      // Nesta parte, ele irá transformar o login do google em login no Firebase, para poder dar as permissões corretas no banco de dados
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication; // Retorna um token e um id único para o usuário da conta do google

      // Com o id e token fornecidos anteriormente, ele irá fazer a autenticação no Firebase
      // Nota-se que a função AuthCredential pertence ao "firebase_auth.dart"
      // Se quiser outras formas de SignIn é só usar outro Provider, como Facebook ou LinkedIn
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );

      final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);

      final FirebaseUser user = authResult.user;

      return user;

    } catch(error){
      return null;
    }
  }


  void _sendMessage({String text, File imgFile}) async {

    final FirebaseUser user = await _getUser();

    if(user == null){
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Não foi possível fazer o Login!!!"),
        )
      );
    }

    String currentPhoneDate = DateTime.now().toString();
    // Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    // DateTime myDateTime = myTimeStamp.toDate(); // TimeStamp to DateTime

    Map<String, dynamic> data = {
      "uid": user.uid,
      "senderName": user.displayName,
      "senderPhotoURL": user.photoUrl,
      "date": currentPhoneDate,
      "time": FieldValue.serverTimestamp()
    };

    if(imgFile != null){
      setState(() {
        _isLoading = true;
      });

      StorageUploadTask task = FirebaseStorage.instance.ref().child(
        user.uid + DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();

      data['imageUrl'] = url;

      setState(() {
        _isLoading = false;
      });
    }

    if(text != null) data['text'] = text;

    Firestore.instance.collection("messages").add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          _currentUser != null ? "Olá, ${_currentUser.displayName}" : "Chat App"
        ),
        actions: <Widget>[
          _currentUser != null ? IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              FirebaseAuth.instance.signOut();
              googleSignIn.signOut();
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("Você sai sucesso!")
                )
              );

            },
          ) : Container()
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder( // Stream é para que sempre algo se alterar, ele refazer
             stream: Firestore.instance.collection('messages').orderBy("time").snapshots(), // stream retorna algo com o passar do tempo, sempre que vir uma mudança ele irá refazer o builder
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                        child: CircularProgressIndicator() // Se estiver carregando ou não tiver conexão, vai mostrar widget de carregamento
                    );
                  default:
                    List<DocumentSnapshot> documents = snapshot.data.documents.reversed.toList();
                    return ListView.builder(
                      itemCount: documents.length, // O tamanho da lista
                      reverse: true, // Para poder mostrar as mensagens atuais em baixo, como nos chats normais
                      itemBuilder: (context, index){
                        // print(documents[index].data);
                        return ChatMessage(documents[index].data, documents[index].data["uid"] == _currentUser?.uid);
                      }
                    );
                }
              },
            )
          ),
          _isLoading ? LinearProgressIndicator() : Container(),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }
}