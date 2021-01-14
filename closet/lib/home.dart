import 'package:closet/myPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'myPage.dart';
import 'closet.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
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
          backgroundColor: colorScheme.surface,
          selectedItemColor: colorScheme.onSurface,
          unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
          selectedLabelStyle: textTheme.caption,
          unselectedLabelStyle: textTheme.caption,
          onTap: (value) {
            // Respond to item press.
            setState(() => _currentIndex = value);
            print(_currentIndex);
          },
          items: [
            BottomNavigationBarItem(
              title: Text('내 옷장'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('코디'),
              icon: Icon(Icons.grade),
            ),
            BottomNavigationBarItem(
              title: Text('달력'),
              icon: Icon(Icons.today),
            ),
            BottomNavigationBarItem(
              title: Text('마이페이지'),
              icon: Icon(Icons.perm_identity),
            ),
          ],
        ),
      ),
    );
  }
}
