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
