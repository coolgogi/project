import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';

class myPage extends StatefulWidget {
  @override
  _myPageState createState() => _myPageState();
}
class _myPageState extends State<myPage> {
  String _animationName = 'day_idle';
  void _onButtonTap() {
    setState(() {
      if (_animationName == 'day_idle' || _animationName == 'switch_day') {
        _animationName = 'switch_night';
      } else {
        _animationName = 'switch_day';
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('엥 유린데영??'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 100,
              height: 40,
              child: GestureDetector(
                onTap: _onButtonTap,
                child: FlareActor(
                  'assets/switch_daytime.flr',
                  animation: _animationName,
                ),
              ),
            ),
          ),
        Center(
          child: Container(
            child: FlatButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text("Logout")),
          ),
        ),
        ]

      )
    );
  }
}
