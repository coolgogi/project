import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  HomePage({this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(email),
        ),
        body: Center(
          child: Container(
            child: FlatButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            }, child: Text("Logout")),
          ),
        ),
      ),
    );
  }
}
