import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendlyeats/chatRoom.dart';

class chatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return myChatList();
  }
}

class myChatList extends StatefulWidget {
  @override
  _myChatList createState() {
    return _myChatList();
  }
}

class _myChatList extends State<myChatList> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat list"),
          backgroundColor: Colors.black,
        ),
        body: Container(
            child: Column(children: <Widget>[ChatRoom(auth.currentUser.uid)])));
  }

  Widget ChatRoom(String uid) {
    return Expanded(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("chatRoom").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');
              default:
                return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    var temp = List<String>.from(document['users']);
                    var temp2 =
                        document['chatRoomName'].toString().split(",")[0];
                    return (temp.toList().contains(auth.currentUser.uid))
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => chatRoom(
                                          temp2, document['chatRoomName'])));
                            },
                            // child: postTile(context, document),
                            child: Container(child: Text(temp2)))
                        : Container();
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }
}
