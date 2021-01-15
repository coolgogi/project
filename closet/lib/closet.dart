import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'text_style.dart';
import 'app.dart';
import 'color.dart';

import 'dart:math';



class closet extends StatefulWidget {
  @override
  _closetState createState() => _closetState();
}

class _closetState extends State<closet>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xFF808080),
              title: Text(
                "I-Clothes",
                style: Theme.of(context).textTheme.headline5,
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.account_circle), onPressed: () {}),
              ],
              centerTitle: true,
              pinned: true,
              floating: true,
              bottom: TabBar(
                  indicatorColor: Colors.purple,
                  labelPadding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  controller: _tabController,
                tabs: [
                  Tab(text: '코디'),
                  Tab(text: '옷장'),
                ],
              ),            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            TabA(),
            const Center(
              child: Text('Display Tab 2',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TabA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: <Widget>[
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi1.jpg'),
              ),
            ),
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi2.jpg'),
              ),
            ),
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi3.jpg'),
              ),
            ),
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi9.jpg'),
              ),
            ),
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi5.jpg'),
              ),
            ),
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi6.jpg'),
              ),
            ),
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi7.jpg'),
              ),
            ),
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi8.jpg'),
              ),
            ),
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi9.jpg'),
              ),
            ),
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi1.jpg'),
              ),
            ),
            Card(
              child: AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Image.asset('assets/codi2.jpg'),
              ),
            ),
          ]),
    );
  }
}