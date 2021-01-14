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
        resizeToAvoidBottomPadding: false,
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
            cody(),
          ],
        ),
        // Column(
        //   children: [
        //     GridView.count(
        //       crossAxisCount: 2,
        //       padding: EdgeInsets.all(16.0),
        //       childAspectRatio: 8.0 / 9.0,
        //       children: <Widget>[
        //         Card(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               AspectRatio(
        //                 aspectRatio: 18.0 / 11.0,
        //                 child: Image.asset('assets/sample.png'),
        //               ),
        //               Padding(
        //                 padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: <Widget>[
        //                     Row(
        //                       children: [
        //                         Text('Title'),
        //                         IconButton(
        //                             icon: Icon(Icons.favorite),
        //                             onPressed: () {}),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         )
        //       ],
        //     ),
        //
        //   ],
        // ),
      ),
    );
  }

  Widget cody() {
    return SingleChildScrollView(
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 20, 360, 0),
              child: Text('상의'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.0),
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 160.0,
                    height: 160,
                    child: Image.asset('assets/top1.JPG'),),
                  Container(
                    width: 160.0,
                      height: 160,
                      child: Image.asset('assets/top2.JPG'),),


                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 360, 0),
              child: Text('하의'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.0),
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 160.0,
                    height: 160,
                    child: Image.asset('assets/bottom1.JPG'),
                  ),
                  Container(
                    width: 160.0,
                    height: 160,
                    child: Image.asset('assets/bottom2.JPG'),
                  ),
                  Container(
                    width: 160.0,
                    height: 160,
                    child: Image.asset('assets/bottom3.JPG'),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 360, 0),
              child: Text('신발'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0.0),
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 160.0,
                    height: 160,
                    child: Image.asset('assets/sho1.JPG'),
                  ),
                  Container(
                    width: 160.0,
                    height: 160,
                    child: Image.asset('assets/sho2.JPG'),
                  ),


                ],
              ),
            ),

          ],),
    );
  }
}
