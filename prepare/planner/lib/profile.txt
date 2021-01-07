import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'constants.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'item_horizontallist.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;

class _ProfileState extends State<Profile> {
  File _image;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
              padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage(),
                  ),
                );
                FirebaseAuth.instance.signOut();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            // 사용자 프로필 사진
            AvatarImage(),

            user.isAnonymous
                ? Align(alignment: Alignment.center, child: Text('Anonymous'))
                : Align(alignment: Alignment.center, child: Text('이유리')),
            SizedBox(height: 20,),
            Text('매너온도',style: TextStyle(fontSize: 18)),
            SizedBox(height: 10,),
            // 사용자 평가 바
            StepProgressIndicator(
              totalSteps: 10,
              currentStep: 6,
              selectedColor: Colors.blue,
              unselectedColor: Colors.black,
            ),
            HorizontalList(),
          ],
        ),
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      decoration: avatarDecoration,
      child: Container(
        decoration: avatarDecoration,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: user.isAnonymous
                  ? AssetImage('assets/camera.png')
                  : Image.network(user.photoURL),
            ),
          ),
        ),
      ),
    );
  }
}