// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'text_style.dart';
import 'app.dart';
import 'color.dart';

class closet extends StatefulWidget {
  @override
  _closet createState() => _closet();
}

class _closet extends State<closet> {

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: BackgroundWhite,
            title: Text(
              "I-Clothes",
              style: Theme.of(context).textTheme.headline5,
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {}
                  ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: '코디'),
                Tab(text: '옷장'),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(16.0),
                  childAspectRatio: 8.0 / 9.0,
                  children: <Widget>[Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 18.0 / 11.0,
                          child: Image.asset('assets/sample.png'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text('Title'),
                                  IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                 ],
              ),
              TabBarView(
                children: [
                  Center(child: Text('코디')),
                  Center(child: Text('옷장')),
                ],
              ),
            ],
          ),
        ),
    );
  }
}