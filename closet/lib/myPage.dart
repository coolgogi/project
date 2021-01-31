import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import 'theme/darkmode.dart';

class myPage extends StatefulWidget {
  @override
  _myPageState createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  bool dark = false;

  String _animationName = 'day_idle';

  void _onButtonTap() {
    setState(() async {
      if (_animationName == 'day_idle' || _animationName == 'switch_day') {
        _animationName = 'switch_night';
        _animationName = 'night_idle';
      } else {
        _animationName = 'switch_day';
        _animationName == 'day_idle';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
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
          Row(
            children: [
              Container(
                child: IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: Icon(Icons.logout)),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(263, 0, 0, 0),
                child: Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => SizedBox(
                    width: 100,
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_animationName == 'day_idle' ||
                              _animationName == 'switch_day') {
                            _animationName = 'switch_night';
                          } else {
                            _animationName = 'switch_day';
                          }
                          notifier.toggleTheme();
                        });
                      },
                      child: FlareActor(
                        'assets/switch_daytime.flr',
                        animation: _animationName,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}