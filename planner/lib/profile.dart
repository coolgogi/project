import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
  FirebaseAuth auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    final User user = auth.currentUser;


    return Scaffold(
        appBar: AppBar(
    leading: IconButton(
    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
    icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
    ),
    actions: <Widget>[
    IconButton(
    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
    icon: Icon(Icons.exit_to_app),
    onPressed: () {Navigator.push(
    context,
    MaterialPageRoute(
    builder: (BuildContext context) => LoginPage(),
    ),
    );
    FirebaseAuth.instance.signOut();
    }
    )
    ],),
    body:  Container(
    child: ListView(
    children: [
      user.isAnonymous
    ? Image.network(
    'http://handong.edu/site/handong/res/img/logo.png',
    width: MediaQuery.of(context).size.width)
        : Image.network(user.photoURL),
//카메라 버튼 , image picker

    Text(
        auth.currentUser.uid
    ),user.isAnonymous
      ?Text('Anonymous')
      :Text(user.email)

    ],
    ),
    ),);
}
}
