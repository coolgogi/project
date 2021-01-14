import 'package:closet/myPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'myPage.dart';
import 'closet.dart';
import 'color.dart';
import 'app.dart';
import 'request.dart';

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
      request(),
      closet(),
      myPage(),
    ];
    // final colorScheme = Theme.of(context).colorScheme;
    // final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      home: Scaffold(
        body: _children[_currentIndex],
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
              title: Text('notification'),
              icon: Icon(Icons.notification_important_outlined),
            ),
            BottomNavigationBarItem(
              title: Text('My Page'),
              icon: Icon(Icons.perm_identity),
            ),
          ],
        ),
      ),
      theme: _closetTheme,
    );
  }
}

final ThemeData _closetTheme = _buildClosetTheme();

ThemeData _buildClosetTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: ColorScheme(
      primary: closetPurple,
      primaryVariant: closetPurple,
      secondary: closetBlack,
      secondaryVariant: closetBlack,
      surface: Colors.white,
      background: BackgroundWhite,
      error: kShrineErrorRed,
      onPrimary: closetPurple,
      onSecondary: closetBlack,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: kShrineErrorRed,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: BackgroundWhite,
    cardColor: BackgroundWhite,
    // accentColor: closetBlack,
    // primaryColor: closetPurple,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: closetBlack,
      colorScheme: base.colorScheme.copyWith(
        primary: closetPurple,
        secondary: closetBlack,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),

    textTheme: _buildClosetTextTheme(base.textTheme),
    primaryTextTheme: _buildClosetTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildClosetTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(
      color: closetPurple,
    ),
  );
}

TextTheme _buildClosetTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w400,
          fontFamily: 'Sansita',
        ),
        headline6: base.headline6.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        displayColor: closetBlack,
      );
}
