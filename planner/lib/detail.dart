
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
class DetailScreen extends StatefulWidget {
  final DocumentSnapshot snapshot;
  DetailScreen(this.snapshot);
  @override
  _DetailScreen createState() => _DetailScreen(snapshot);
}
class _DetailScreen extends State<DetailScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  final DocumentSnapshot snapshot;
  final handongURL ='http://handong.edu/site/handong/res/img/logo.png';
  String ID;

  _DetailScreen(this.snapshot){
    ID = snapshot.id;
  }

  Map<String, dynamic> get product {
    return snapshot.data();
  }

  Widget get image {
    return GestureDetector(
      child: Image.network(
        snapshot.data()['photo'],
        fit: BoxFit.fitWidth,
        width: 500,
        height: 240,
      ),
    );
  }

  Widget get name {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 30.0, 16.0, 0.0),
      child: Text(
        "${product['name']}",
        style: TextStyle(
          fontWeight: FontWeight.bold,

          fontSize: 25,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget get price {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 10.0, 16.0, 5.0),
      child: Text(
        "\$ ${product['price']}",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }


  Widget get description {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 10.0, 16.0, 5.0),
      child: Text(
        "${product['description']}",
        style: TextStyle(
          fontSize: 15,
        ),
        maxLines: 1,
      ),
    );
  }


  Widget get divider {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 16.0, 5.0),
      child: const Divider(
        color: Colors.grey,
        height: 1.0,
        thickness: 1,
        indent: 2,
        endIndent: 0,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    DocumentReference document = FirebaseFirestore.instance.collection('product').doc(ID);

    void _onDelete(DocumentReference document) async{
      WriteBatch batch = FirebaseFirestore.instance.batch();
      await batch.delete(document);
      await batch.commit();
      setState(() {
        document == null;
      });
      Navigator.pushNamed(context, '/home');
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Detail'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.mode_edit,
              semanticLabel: 'update',
            ),
            onPressed: () {
              if (product['auth'] == auth.currentUser.uid) {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Text("edit page");
                }));
              } else {


                scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text("You are not a author")));
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              semanticLabel: 'delete',
            ),
            onPressed: () async{
              if (product['auth'] == auth.currentUser.uid) {
                await _onDelete(document);
              }
              else {
                scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text("You are not a author")));
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: document.snapshots(),
          builder: (BuildContext context,  AsyncSnapshot<DocumentSnapshot> snapshot ){
            DocumentSnapshot documentSnapshot = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            else if(snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            else if(snapshot.data.data() == null){
              return Center(child: CircularProgressIndicator());
            }

            return _body(documentSnapshot);
          }
      ),
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

class _body extends StatelessWidget {
  final DocumentSnapshot snapshot;
  _body(this.snapshot);

  FirebaseAuth auth = FirebaseAuth.instance;

  final handongURL ='http://handong.edu/site/handong/res/img/logo.png';


  Map<String, dynamic> get product {
    return snapshot.data();
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        image,
        Row(
          children: [
            name,
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: IconButton(
                icon: Icon(
                  Icons.thumb_up_alt_sharp,
                  color: Colors.red,
                ),

                onPressed: () {

                  if(product['likePeople'] == null  || product['likePeople'].contains(auth.currentUser.uid) == false ){
                    snapshot.reference.update({
                      'likes': FieldValue.increment(1),
                      'likePeople': FieldValue.arrayUnion(
                          [auth.currentUser.uid])
                    });
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: const Text('I LIKE IT!'),),);

                  }
                  else {
                    Scaffold.of(context).showSnackBar(SnackBar(content: const Text('You can only do it once!!'),),);
                  }

                },

              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: Text(
                "${product['likes']}",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
                maxLines: 1,
              ),
            ),

          ],
        ),
        Row(
          children: [
            price,
            SizedBox(width: 140),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.white)),
              color: Colors.black,
              textColor: Colors.white,

              child: Text('채팅하기', style: TextStyle(fontSize: 24)),
              onPressed: () => auth.currentUser.uid != snapshot.data()['uid']
                  ? makingChatRoom(
                  auth.currentUser.uid, snapshot.data()['uid'], snapshot.data()['name'], context)
                  : print("no"),
            ),
          ],
        ),

        divider,
        description,
      ],
    );
  }

  Widget get image {
    return GestureDetector(
      child: Image.network(
        snapshot.data()['photo'],
        fit: BoxFit.fitWidth,
        width: 500,
        height: 240,
      ),
    );
  }

  Widget get name {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 30.0, 16.0, 0.0),
      child: Text(
        "${product['name']}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget get price {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 10.0, 16.0, 5.0),
      child: Text(
        "\$ ${product['price']}",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }


  Widget get description {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 10.0, 16.0, 5.0),
      child: Text(
        "${product['description']}",
        style: TextStyle(
          fontSize: 15,
        ),
        maxLines: 1,
      ),
    );
  }


  Widget get divider {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 16.0, 5.0),
      child: const Divider(
        color: Colors.grey,
        height: 1.0,
        thickness: 1,
        indent: 2,
        endIndent: 0,
      ),
    );
  }
  void success(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('ChatRoom was created!'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
                onPressed: () {
                  Navigator.pop(context, '확인');
                  // Navigator.push()
                },
              )
            ],
          );
        });
  }
  void makingChatRoom(
      String user1, String user2, String title, BuildContext context) {
    List<String> users = [user1, user2];
    String chatRoomName = "$title,$user1,$user2";
    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomName": chatRoomName,
    };
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomName)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
    print("==================================================================");
    print("[[[$user1, $user2]]]");
    print("==================================================================");
    success(context);
  }

}

