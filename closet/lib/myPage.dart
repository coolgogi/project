import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';

class myPage extends StatefulWidget {
  @override
  _myPageState createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  bool dark = false;

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
          backgroundColor: Color(0xFF808080),
          title: Text(
            "I-Clothes : my Page",
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
          ],
          automaticallyImplyLeading: false,
        ),
        body: ListView(children: <Widget>[
          SizedBox(width: 900),
            Container(
              margin: EdgeInsets.fromLTRB(320, 0, 0, 0),
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
        ]));
  }
}
