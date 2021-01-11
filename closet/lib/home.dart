import 'package:closet/my_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'my_page.dart';

class HomePage extends StatefulWidget {

  HomePage({this.email});

  final String email;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.email),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.perm_identity), 
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyPage())
                  );
                })
          ],
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
