import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

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
          color: Colors.blueAccent,
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
          color: Colors.blue,
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
          color: Colors.blue,
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
    );
  }
}

class _body extends StatefulWidget {
  final DocumentSnapshot snapshot;
  _body(this.snapshot);
  @override
  _bodyState createState() => _bodyState(snapshot);
}

class _bodyState extends State<_body> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final DocumentSnapshot snapshot;
  final handongURL ='http://handong.edu/site/handong/res/img/logo.png';

  _bodyState(this.snapshot);

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
        price,
        RaisedButton(
          child: Text('start chatting', style: TextStyle(fontSize: 24)),
          onPressed: () => auth.currentUser.uid != snapshot.data()['uid']
              ? makingChatRoom(
              auth.currentUser.uid, snapshot.data()['uid'], snapshot.data()['name'], context)
              : setState(() {
            print(" you can\' make chat room");
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('you can\'t make chat room')));
          }),
        ),
        divider,
        description,
        Container(
            padding: EdgeInsets.fromLTRB(40.0, 170.0, 0.0, 0.0),
            child: (product['auth'] != null) ? Text('creator : ${product['auth']}') : Text('NO CREATOR')),
        Container(
            padding: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
            child:
            (product['creation'] != null) ? Text('${product['creation'].toDate().toString()} Created') : Text('NO CREATION TIME')),
        Container(
            padding: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
            child:
            (product['modified'] != null) ? Text('${product['modified'].toDate().toString()} Modified') : Text('NO MODIFIED TIME')),
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
          color: Colors.blueAccent,
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
          color: Colors.blue,
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
          color: Colors.blue,
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
}
/*
import 'update.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailPage extends StatefulWidget {
  String photo;
  String name;
  int price;
  String description;
  String docName;
  String uid;
  String created;
  String updated;
  int likes;

  DetailPage(this.photo, this.name, this.price, this.description, this.docName,
      this.uid, this.created, this.updated, this.likes);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void _delete(BuildContext context) {
    {
      String fileNameToDelete = basename(widget.name);
      Reference firebaseStorageRefToDelete =
          FirebaseStorage.instance.ref().child(fileNameToDelete);
      firebaseStorageRefToDelete.delete();
      //firestore delete
      FirebaseFirestore.instance
          .collection('product')
          .doc(widget.docName)
          .delete();
    }
  }

  void _addLikes(BuildContext context) {
    FirebaseFirestore.instance
        .collection('product')
        .doc(widget.docName)
        .update({'likes': widget.likes + 1});
    FirebaseFirestore.instance
        .collection('product')
        .doc(widget.docName)
        .collection('likedMembers')
        .doc(widget.docName)
        .set({widget.uid: widget.uid});
    setState(() {
      print("I like it");
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('I like it')));
    });
  }

  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          Builder(
            builder: (ctx) => IconButton(
              padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
              icon: Icon(Icons.auto_fix_normal),
              onPressed: () => auth.currentUser.uid == widget.uid
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext ctx) => UpdateProduct(
                          widget.photo,
                          widget.name,
                          widget.price,
                          widget.description,
                          widget.docName,
                          widget.uid,
                        ),
                      ),
                    )
                  : setState(() {
                      print(" you are not allowed to edit");
                      Scaffold.of(ctx).showSnackBar(SnackBar(
                          content: Text('you are not allowed to edit')));
                    }),
            ),
          ),
          Builder(
              builder: (crx) => IconButton(
                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                    icon: Icon(Icons.restore_from_trash_sharp),
                    onPressed: () => auth.currentUser.uid == widget.uid
                        ? _delete(context)
                        : setState(() {
                            print(" you are not allowed to delete");
                            // ignore: deprecated_member_use
                            Scaffold.of(crx).showSnackBar(SnackBar(
                                content:
                                    Text('you are not allowed to delete')));
                          }),
                  ))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 15 / 11,
              child: Image.network(
                widget.photo,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(fontSize: 30),
                        ),
                        Row(children: [
                          Builder(
                              builder: (ccc) => IconButton(
                                  icon: Icon(
                                    Icons.thumb_up,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => FirebaseFirestore.instance
                                          .collection('product')
                                          .doc(widget.docName)
                                          .collection('likedMembers')
                                          .doc(widget.docName)
                                          .get()
                                          .then((DocumentSnapshot
                                              documentSnapshot) {
                                        documentSnapshot.exists
                                            ? setState(() {
                                                print(
                                                    " You can only do it once");
                                                // ignore: deprecated_member_use
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'You can only do it once')));
                                              })
                                            : _addLikes(ccc);
                                      }))),
                          Text(
                            widget.likes.toString(),
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                      ]),
                  SizedBox(height: 10),
                  Text(
                    formatter.format(widget.price),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.description,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'creator:<' +
                  widget.uid +
                  '>\n' +
                  widget.created +
                  ' Created\n' +
                  widget.updated +
                  '  Modified',
              style: TextStyle(fontSize: 10),
            ),
            RaisedButton(
              child: Text('start chatting', style: TextStyle(fontSize: 24)),
              onPressed: () => auth.currentUser.uid != widget.uid
                  ? makingChatRoom(
                      auth.currentUser.uid, widget.uid, widget.name, context)
                  : setState(() {
                      print(" you can\' make chat room");
                      // ignore: deprecated_member_use
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('you can\'t make chat room')));
                    }),
            ),
          ],
        ),
      ),
    );
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
}
*/