import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class chatRoom extends StatefulWidget {
  // final String chatRoomId;
  String docsName;
  String fullName;
  chatRoom(String tp, String tp2) {
    docsName = tp;
    fullName = tp2;
  }

  @override
  _chatRoomState createState() => _chatRoomState(docsName, fullName);
}

class _chatRoomState extends State<chatRoom> {
  String docsName;
  String fullName;
  Stream<QuerySnapshot> chats;

  _chatRoomState(String tp, String tp2) {
    docsName = tp;
    fullName = tp2;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  Stream documentStream =
      FirebaseFirestore.instance.collection('chatRoom').doc().snapshots();
  TextEditingController messageEditingController = TextEditingController();
  String previousDate;
  final _blankFocusnode = FocusNode();

  @override
  void initState() {
    chats = FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(fullName)
        .collection('chats')
        .orderBy('date', descending: true)
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              leading: InkWell(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Center(
                    child: Text(
                  docsName,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
              ),
            ),
            body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(_blankFocusnode);
                },
                child: Column(children: [
                  Expanded(child: chatMessages()),
                  sendMessageBox(),
                  SizedBox(
                    height: 10,
                  )
                ]))));
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(15),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return
                      // Container();
                      MessageTile(
                          context,
                          snapshot.data.documents[index].data()['message'],
                          auth.currentUser.uid ==
                              snapshot.data.documents[index].data()['sendBy'],
                          snapshot.data.documents[index].data()['date'],
                          index == snapshot.data.documents.length - 1
                              ? previousDate = '0'
                              : previousDate = ((snapshot
                                      .data.documents[index + 1]
                                      .data()['date'])
                                  .split(RegExp(r' |:')))[0]);
                })
            : Container();
      },
    );
  }

  // ignore: always_declare_return_types
  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      var chatMessageMap = <String, dynamic>{
        'sendBy': auth.currentUser.uid,
        'message': messageEditingController.text,
        'date': DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now()),
      };
      FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(fullName)
          .collection('chats')
          .add(chatMessageMap)
          .catchError((e) {
        print(e.toString());
      });
    }
  }

  Widget sendMessageBox() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      padding: EdgeInsets.fromLTRB(15, 8, 5, 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: TextField(
            style: TextStyle(fontSize: 18),
            controller: messageEditingController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(15, 23, 0, 0),
              fillColor: Colors.grey[200],
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown, width: 1.5),
                  borderRadius: BorderRadius.circular(20)),
            ),
          )),
          SizedBox(
            width: 5,
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.blue,
            onPressed: () {
              addMessage();
            },
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MessageTile(BuildContext context, String message, bool sendByMe,
      String date, String previousDate) {
    var allTime = date.split(RegExp(r' |:'));
    var todayDate = allTime[0];
    var hour = allTime[1];
    var minute = allTime[2];
    var m = '오전';
    var hourInt = int.parse(hour);
    if (hourInt > 12) {
      hourInt = hourInt - 12;
      m = '오후';
    }
    hour = hourInt.toString();
    var time = m + ' ' + hour + ':' + minute;
    return Column(
      children: <Widget>[
        previousDate != todayDate
            ? Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 20,
                child: Center(
                    child: Text(
                  todayDate,
                  style: TextStyle(fontSize: 12),
                )),
              )
            : Container(
                child: null,
              ),
        Row(
          mainAxisAlignment:
              sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            sendByMe
                ? Padding(
                    padding: const EdgeInsets.only(right: 3, bottom: 7),
                    child: Text(
                      '$time',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  )
                : Container(),
            Container(
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.60),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 7),
                decoration: BoxDecoration(
                  color: sendByMe ? Colors.blue[100] : Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 1, blurRadius: 1),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft:
                        sendByMe ? Radius.circular(23) : Radius.circular(0),
                    bottomRight:
                        sendByMe ? Radius.circular(0) : Radius.circular(23),
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            sendByMe
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 3, bottom: 7),
                    child: Text(
                      '$time',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
