// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'text_style.dart';
import 'app.dart';
import 'color.dart';

// ignore: camel_case_types
class closet extends StatefulWidget {
  @override
  _closet createState() => _closet();
}

// ignore: camel_case_types
class _closet extends State<closet> {
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF808080),
          title: Text(
            "I-Clothes",
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
          ],
          bottom: TabBar(
            indicatorColor: Colors.purple,
            tabs: [
              Tab(text: '코디'),
              Tab(text: '옷장'),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: TabBarView(
          children: [
            Center(child: Text('코디')),
            Center(child: Text('옷장')),
          ],
        ),
      ),
    );
  }
}
