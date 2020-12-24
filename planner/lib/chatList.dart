import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendlyeats/chatRoom.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
          backgroundColor: Colors.black,
          title: Text("Chat list"),
          leading: IconButton(
            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamed(context, '/home'),
          ),
        ),
        body: Container(
            child: Column(children: <Widget>[ChatRoom(auth.currentUser.uid)])),
      bottomNavigationBar: ConvexAppBar(
      style: TabStyle.react,
      items: [
        TabItem(icon: Icons.person),
        TabItem(icon: Icons.home),
        TabItem(icon: Icons.message_rounded),
      ],
      color: Colors.white,
      backgroundColor: Colors.black,
      initialActiveIndex: 2 /*optional*/,
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

    ),);
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
  Widget ChatRoom(String uid) {

    return Expanded(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("chatRoom").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text("Loading...");
              default:
                return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    var temp = List<String>.from(document['users']);
                    String temp2 =
                        document['chatRoomName'].toString().split(",")[0];
                    return Column(
                      children: [
                        (temp.toList().contains(auth.currentUser.uid))
                    ? InkWell(
                    onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => chatRoom(
                    temp2, document['chatRoomName'])));
                    },
                    // child: postTile(context, document),

                    child: ListTile(title: Text(temp2),

                    trailing: Icon(Icons.arrow_forward_ios),
                    leading: Icon(Icons.account_circle),),)
                        : Container(),

                      ],
                    );

                  }).toList(),

                );
            }
          },
        ),
      ),
    );
  }

}
