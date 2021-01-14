import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class myPage extends StatefulWidget {
  myPage();

  @override
  _myPage createState() => _myPage();
}

class _myPage extends State<myPage> {
  int _currentIndex = 0;
  List<Widget> _children;
  bool dark = false;

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
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              "Dark Mode",
              textAlign: TextAlign.center,
            ),
          ),
          CupertinoSwitch(
              value: dark,
              onChanged: (bool value) {
                setState(() {
                  dark = value;
                });
              })
        ],
      ),
    );
  }
}
