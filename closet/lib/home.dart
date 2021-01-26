import 'package:closet/analyze.dart';
import 'package:closet/myPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'closet.dart';
import 'request.dart';
import 'myPage.dart';
import 'theme/colors.dart';
import 'theme/darkmode.dart';
import 'calendar.dart';
import 'my.dart';

class HomePage extends StatefulWidget {
  HomePage({this.email});

  final String email;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  //List<Widget> _children;
  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      closet(),
      request(),
      Calendar(),
      My(),
    ];
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme? dark_theme : light_theme,
            home: Scaffold(
              body: _children[_currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                selectedItemColor:
                notifier.darkTheme ? PrimaryColorDark : PrimaryColorLight,
                //unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
                unselectedItemColor:
                notifier.darkTheme ? SecondaryDark : SecondaryLight,
                selectedLabelStyle: Theme.of(context).textTheme.caption,
                unselectedLabelStyle: Theme.of(context).textTheme.caption,
                onTap: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      title: Text('드레스룸'),
                      //icon: Icon(Icons.home_outlined)
                      icon: Icon(Icons.checkroom_outlined)
                  ),
                  BottomNavigationBarItem(
                      title: Text('옷장 분석'),
                      icon: Icon(Icons.pie_chart_outlined)
                  ),
                  BottomNavigationBarItem(
                      title: Text('달력'),
                      icon: Icon(Icons.date_range_outlined)
                  ),
                  BottomNavigationBarItem(
                      title: Text('마이 페이지'),
                      icon: Icon(Icons.perm_identity)
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



// import 'package:closet/myPage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'myPage.dart';
// import 'closet.dart';
// import 'request.dart';
// import 'theme/darkmode.dart';
// import 'theme/colors.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({this.email});
//
//   final String email;
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   List<Widget> _children;
//
//   @override
//   Widget build(BuildContext context) {
//     _children = [
//       closet(),
//       request(),
//       closet(),
//       myPage(),
//     ];
//     // final colorScheme = Theme.of(context).colorScheme;
//     // final textTheme = Theme.of(context).textTheme;
// // <<<<<<< Updated upstream
//     return ChangeNotifierProvider(
//         create: (_) => ThemeNotifier(),
//         child: Consumer<ThemeNotifier>(
//             builder: (context, ThemeNotifier notifier, child) {
//           return MaterialApp(
//             theme: notifier.darkTheme ? dark_theme : light_theme,
//             home: Scaffold(
//               body: _children[_currentIndex],
//               bottomNavigationBar: BottomNavigationBar(
//                 type: BottomNavigationBarType.fixed,
//                 currentIndex: _currentIndex,
//                 selectedItemColor: notifier.darkTheme ? PrimaryColorDark : PrimaryColorLight,
//                 //unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
//                 unselectedItemColor: notifier.darkTheme ? SecondaryDark : SecondaryLight,
//                 selectedLabelStyle: Theme.of(context).textTheme.caption,
//                 unselectedLabelStyle: Theme.of(context).textTheme.caption,
//                 onTap: (value) {
//                   // Respond to item press.
//                   setState(() => _currentIndex = value);
//                   print(_currentIndex);
//                 },
//                 items: [
//                   BottomNavigationBarItem(
//                     title: Text('Home'),
//                     icon: Icon(Icons.home_outlined),
//                   ),
//                   BottomNavigationBarItem(
//                     title: Text('With People'),
//                     icon: Icon(Icons.question_answer_outlined),
//                   ),
//                   BottomNavigationBarItem(
//                     title: Text('Favorite'),
//                     icon: Icon(Icons.favorite_outline),
//                   ),
//                   BottomNavigationBarItem(
//                     title: Text('My Page'),
//                     icon: Icon(Icons.perm_identity),
//                   ),
//                 ],
//               ),
//             ),
//             // theme: notifier.darkTheme ? dark, light,
//           );
//         }));
//   }
// }

