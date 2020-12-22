import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'profile.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
    children: <Widget>[
    SizedBox(height: 80.0),
    Column(
    children: <Widget>[
    Image.asset('assets/diamond.png'),
    SizedBox(height: 16.0),
    Text('SHRINE'),
    ],
    ),
    SizedBox(height: 120.0),

//구글 로그인
    ButtonBar(
    children:<Widget> [
    RaisedButton(
    child: Text("GOOGLE"),
    onPressed:()
    {
    signInWithGoogle();
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (BuildContext context) => HomePage(),
    ),
    );
    }
    )
    ],
    ),
    SizedBox(
    height: 12.0),

//익명 로그인
    ButtonBar(
    children:<Widget> [
    RaisedButton(
    child: Text("Anonymous"),
    onPressed:(){
    signAnonymous();
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (BuildContext context) => HomePage(),
    ),
    );
    }
    )
    ]
    ,
    )
    ,
    ]
    ,


  )

  ,

  )

  ,

  );
}}


void signAnonymous() async {
  UserCredential userCredential = await FirebaseAuth.instance
      .signInAnonymously();
}
 GoogleSignInAccount googleUser;
Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
   googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}


