import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  final String title = 'Sign In & Out';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            SizedBox(height: 220.0),
            Center(child: Text('MY Shopping',style: TextStyle(fontWeight:FontWeight.bold),)),
            SizedBox(height:100),
            /*
            Column(
              children: <Widget>[
                Image.asset('assets/diary.png',height:60, width: 60),
                SizedBox(height: 16.0),
              ],
            ),
            */

            SizedBox(height: 80.0),

            _AnonymouslySignInSection(),

            _OtherProvidersSignInSection(),
/*
            Container(
              margin:EdgeInsets.fromLTRB(180.0, 10.0, 60.0, 20.0),
              child: RaisedButton(
                child: Text('Logout'),
                onPressed: () async{
                  await _signOut();
                  //  Navigator.pushNamed(context, '/home');
                },
              ),
            ),
              */

          ],
        ),
      ),
    );
  }

  void _signOut() async {
    await _auth.signOut();
  }
}


class _AnonymouslySignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnonymouslySignInSectionState();
}

class _AnonymouslySignInSectionState extends State<_AnonymouslySignInSection> {
  bool _success;
  String _userID;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 16.0),
          alignment: Alignment.center,
          child: SignInButtonBuilder(
            text: "Guest",
            icon: Icons.person_outline,
            backgroundColor: Colors.deepPurple,
            onPressed: () async {
              await _signInAnonymously();
             await Navigator.pushNamed(context, '/home');

            },
          ),
        ),
        Visibility(
          visible: _success == null ? false : true,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success == null
                  ? ''
                  : (_success
                  ? 'Successfully signed in, uid: ' + _userID
                  : 'Sign in failed'),
              style: TextStyle(color: Colors.red),
            ),
          ),
        )
      ],
    );
  }

  // Example code of how to sign in anonymously.
  void _signInAnonymously() async {
    try {
      final User user = (await _auth.signInAnonymously()).user;

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Signed in Anonymously as user ${user.uid}"),
      ));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in Anonymously"),
      ));
    }
  print("gogo");

  }
}

class _EmailSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailSignInSectionState();
}

class _EmailSignInSectionState extends State<_EmailSignInSection> {
  bool _success;
  String _userID;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            filled: true,
            labelText: 'Username',
          ),
        ),
        SizedBox(height: 12.0),
        // TODO: Wrap Password with AccentColorOverride (103)
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            filled: true,
            labelText: 'Password',
          ),
          obscureText: true,
        ),
        SizedBox(height: 12.0),
        RaisedButton(
          child: Text('NEXT'),
          onPressed: () async{
            await _signInEmail();
            //  Navigator.pushNamed(context, '/home');
          },
        ),
        Visibility(
          visible: _success == null ? false : true,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _success == null
                  ? ''
                  : (_success
                  ? 'Successfully signed in, uid: ' + _userID
                  : 'Sign in failed'),
              style: TextStyle(color: Colors.red),
            ),
          ),
        )
      ],
    );
  }

  // Example code of how to sign in anonymously.
  void _signInEmail() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _usernameController.text,
          password: _passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }


  }
}

class _OtherProvidersSignInSection extends StatefulWidget {
  _OtherProvidersSignInSection();

  @override
  State<StatefulWidget> createState() => _OtherProvidersSignInSectionState();
}

class _OtherProvidersSignInSectionState
    extends State<_OtherProvidersSignInSection> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 25.0),
          alignment: Alignment.center,
          child: SignInButton(Buttons.GoogleDark,
            text: "GOOGLE",
            onPressed: () async {
              await _signInWithGoogle();
              Navigator.pushNamed(context, '/grid');
            },
          ),
        ),
      ],
    );
  }

  //Example code of how to sign in with Google.
  void _signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
        print('signin');
      } else {
        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final GoogleAuthCredential googleAuthCredential =
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
      }

      final user = userCredential.user;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Sign In ${user.uid} with Google"),
      ));
    } catch (e) {
      print(e);

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Google: ${e}"),
      ));
    }
  }
}