import 'package:closet/myPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'myPage.dart';
import 'closet.dart';
import 'color.dart';
import 'app.dart';


class HomePage extends StatefulWidget {
  HomePage({this.email});

  final String email;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _children;

  @override
  Widget build(BuildContext context) {
    _children = [
      closet(),
      closet(),
      closet(),
      myPage(),
    ];
    // final colorScheme = Theme.of(context).colorScheme;
    // final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.email),
        //   actions: <Widget>[
        //     IconButton(
        //         icon: Icon(Icons.perm_identity),
        //         onPressed: () {
        //           Navigator.of(context)
        //               .push(MaterialPageRoute(builder: (context) => MyPage()));
        //         })
        //   ],
        // ),
        body: _children[_currentIndex],
        // Center(
        //   child: Container(
        //     child: FlatButton(
        //         onPressed: () {
        //           FirebaseAuth.instance.signOut();
        //         },
        //         child: Text("Logout")),
        //   ),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          //selectedItemColor: closetPurple,
          unselectedItemColor: Theme.of(context).colorScheme.primary,
          //unselectedItemColor: closetBlack,
          selectedLabelStyle: Theme.of(context).textTheme.caption,
          unselectedLabelStyle: Theme.of(context).textTheme.caption,
          onTap: (value) {
            // Respond to item press.
            setState(() => _currentIndex = value);
            print(_currentIndex);
          },
          items: [
            BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              title: Text('With People'),
              icon: Icon(Icons.grade_outlined),
            ),
            BottomNavigationBarItem(
              title: Text('My Page'),
              icon: Icon(Icons.perm_identity),
            ),
            BottomNavigationBarItem(
              title: Text('notification'),
              icon: Icon(Icons.notification_important_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
