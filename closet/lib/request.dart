import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class request extends StatefulWidget {
  @override
  _request createState() => _request();
}

// ignore: camel_case_types
class _request extends State<request> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "I-Clothes",
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Text("\n코디 요청", textAlign: TextAlign.end),
          Codi_request(),
          Text("\nBest Stylist", textAlign: TextAlign.end),
          best_Stylist(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('코디 도움받기', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget Codi_request() {
    return Expanded(
        child: Container(
            child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("request")
          .orderBy("datetime", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text("Loading...");
          default:
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return InkWell(
                  onTap: () {},
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(children: [
                        ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text(document['title']),
                          subtitle: Text(document['description']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          // child: Text(
                          //   'Hello',
                          //   style: TextStyle(
                          //       color: Colors.black.withOpacity(0.6)),
                          // )
                        )
                      ])),
                );
              }).toList(),
            );
        }
      },
    )));
  }

  Widget best_Stylist() {
    return Expanded(
        child: Container(
            child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("user")
          .orderBy("score", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text("Loading...");
          default:
            return ListView(
              // scrollDirection: Axis.horizontal,
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return InkWell(
                  onTap: () {},
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(children: [
                        ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text(document['nickname']),
                          subtitle: Text(document['score'].toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          // child: Text(
                          //   'Hello',
                          //   style: TextStyle(
                          //       color: Colors.black.withOpacity(0.6)),
                          // )
                        )
                      ])),
                );
                // return Container(
                //     child: Card(
                //         clipBehavior: Clip.antiAlias,
                //         child: Column(children: [
                //           ListTile(
                //             leading: Icon(Icons.account_circle),
                //             title: Text(document['nickname']),
                //             subtitle: Text(document['score'].toString()),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(16.0),
                //             // child: Text(
                //             //   'Hello',
                //             //   style: TextStyle(
                //             //       color: Colors.black.withOpacity(0.6)),
                //             // )
                //           )
                //         ])));
              }).toList(),
            );
        }
      },
    )));
  }
}
