// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class closet extends StatefulWidget {
  @override
  _closet createState() => _closet();
}

class _closet extends State<closet> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '내 옷장',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('엥 유린데영??'),
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff5808e5),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: '코디', icon: Icon(Icons.favorite)),
                Tab(text: '옷장', icon: Icon(Icons.music_note)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Text('코디')),
              Center(child: Text('옷장')),
            ],
          ),
        ),
      ),
    );
  }
}
