import 'package:flutter/material.dart';
import 'Exercise.dart';
import 'ExerciseButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

/*
https://firebase.google.com/docs/flutter/setup
https://github.com/flutter/plugins
https://pub.dartlang.org/packages/firebase_auth#-example-tab-
https://codelabs.developers.google.com/codelabs/flutter-firebase/index.html#8
https://firebase.google.com/docs/firestore/query-data/queries?authuser=0
https://firebase.google.com/docs/auth/?authuser=0
https://flutter.io/android-release/
https://stackoverflow.com/questions/50661220/flutter-firestore-offline-capabilities
https://www.youtube.com/watch?v=HzKdJekhXoc
https://www.youtube.com/watch?v=8M-Fa239Hy4
https://stackoverflow.com/questions/29182581/global-variables-in-dart
https://console.firebase.google.com/u/1/project/exercise-2018/overview
*/


Future<void> main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Exercise',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new MyHomePage(title: 'Exercise Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Exercise pompes = new Exercise(
      "Pompes",
      new Icon(Icons.directions_run),
      Colors.white);

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: new Icon(Icons.directions_run),
        title: new Text(widget.title),
      ),
      body: new GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 10.0,
        crossAxisCount: 4,
        children: <Widget>[
          new IconButton(icon: new Icon(Icons.check_circle), onPressed: signIn),
          new ExerciseButton(context, pompes, _scaffoldKey),
        ],
      )
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void dataBaseTest(FirebaseUser user) {
    Firestore.instance.collection('Utilisateurs').document(user.displayName)
        .setData({ 'Nom': 'Antoine'});
  }

  void signIn(){
     _handleSignIn()
        .then((FirebaseUser user) => dataBaseTest(user))
        .catchError((e) => print(e));
  }

  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + user.displayName);
    return user;
  }
}

