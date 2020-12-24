import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'detail.dart';
import 'package:friendlyeats/chatList.dart';


import 'package:convex_bottom_bar/convex_bottom_bar.dart';



FirebaseAuth _auth =  FirebaseAuth.instance;

User user;
String uid;
Query query;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _filterOrSort = "Recent";

  void _onActionSelected(String value) async {
    setState(() {
      _filterOrSort = value;
    });
  }

  void _userInit() async {
    _auth = await FirebaseAuth.instance;
    user = await _auth.currentUser;
    uid = await user.uid;
    query = await FirebaseFirestore.instance.collection('product');

    switch (_filterOrSort) {
      case "Recent":
        query = query.orderBy('creation', descending: true);
        break;

      case "Last":
        query = query.orderBy('creation', descending: false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _userInit();

    final columnCount =
    MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4;

    final width = MediaQuery.of(context).size.width / columnCount;
    const height = 400;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,


        title: Text('App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart_rounded,
              semanticLabel: 'cart',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          ),

          IconButton(
            icon: Icon(
              Icons.add,
              semanticLabel: 'add',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              SizedBox(width: 150),
              DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                    child: Text('Recent'),
                    value: 'Recent',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Last'),
                    value: 'Last',
                  ),
                ],
                value: _filterOrSort,
                onChanged: (String newValue) async {
                  await _onActionSelected(newValue);
                },
              ),
              SizedBox(width: 120),
              //format_list_bulleted
              IconButton(
                icon: Icon(
                  Icons.format_list_bulleted,
                  semanticLabel: 'list',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ],
          ),
          Expanded(
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
                  stream: FirebaseFirestore.instance
                      .collection('product')
                      .snapshots(),
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
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
          childAspectRatio: width / height,

                      ),
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
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.person),
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.message_rounded),
        ],
        color: Colors.white,
        backgroundColor: Colors.black,
        initialActiveIndex: 1 /*optional*/,
        onTap: (int i) {
          if (i == 0){
            Navigator.pushNamed(context, '/profile');
          }
          if (i == 1){
            Navigator.pushNamed(context, '/home');
          }
          if (i == 2){
            Navigator.pushNamed(context, '/chatList');
          }
        },

      ),
    );
  }
}

class Sort extends StatefulWidget {
  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<Sort> {
  String dropdownValue = 'Recent';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          child: Text('Recent'),
          value: 'Recent',
        ),
        DropdownMenuItem<String>(
          child: Text('Last'),
          value: 'Last',
        ),
      ],
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
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
    return Container(
        child: AspectRatio(
          aspectRatio: 1,
            child: Image.network(product['photo'],fit: BoxFit.fitWidth,),
        ),
        height: 250,

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
    return
      InkWell(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                image,

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Text("${product['name']}",
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .apply(fontSizeFactor: 0.8)),
                        SizedBox(height: 16.0),
                      Text(
                        '\₩ ${product['price']}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                        SizedBox(height: 10.0),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen(snapshot);
          }));
        },
      );

  }
}
