import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class myPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('엥 유린데영??'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff5808e5),
      ),
      body: Center(
        child: Container(
          child: FlatButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("Logout")),
        ),
      ),
    );
  }
}
