import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'detail.dart';

class HorizontalList extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              '대여 아이템',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
              ),
            ),
          ),
          Container(
            height: 200,
            child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot == null) {
                  return Center(child: CircularProgressIndicator());
                }
                final user = snapshot.data;
                if (user == null) {
                  return Center(child: Text('noUser'));
                }

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('product').snapshots(),
                      //.collection('user').doc('uid').collection('lend').snapshots(),
                  builder: (context, stream) {
                    if (stream.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (stream.hasError) {
                      return Center(child: Text(stream.error.toString()));
                    } else if (stream.data.docs.length == 0) {
                      return Center(child: CircularProgressIndicator());
                    }
                    QuerySnapshot querySnapshot = stream.data;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: querySnapshot.size,
                      itemBuilder: (context, index) =>
                          Product(querySnapshot.docs[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Product extends StatelessWidget {
  /// Contains all snapshot data for a given movie.
  final DocumentSnapshot snapshot;

  /// Initialize a [Move] instance with a given [DocumentSnapshot].
  Product(this.snapshot);

  /// Returns the [DocumentSnapshot] data as a a [Map].
  Map<String, dynamic> get product {
    return snapshot.data();
  }

  /// Returns the movie poster.
  Widget get image {
    return AspectRatio(
      aspectRatio: 19 / 11,
      child: Image.network(
        product['photo'],
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget get name {
    return Text(
      "${product['name']}",
      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Plaster'),
      maxLines: 1,
    );
  }

  Widget get price {
    return Text(
      '\$ ${product['price']}',
      style: TextStyle(
        fontSize: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(snapshot)));
            },
            child: Container(
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.5, 1.0),
                    spreadRadius: 0.5,
                    blurRadius: 6)
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  //height: 130.0,
                  //width: 180.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: image,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0, top: 8.0),
                          child: name,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: <Widget>[Spacer(), price],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
