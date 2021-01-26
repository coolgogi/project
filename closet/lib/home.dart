import 'package:closet/analyze.dart';
import 'package:closet/myPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'myPage.dart';
import 'closet.dart';
import 'request.dart';
import 'theme/darkmode.dart';
import 'theme/colors.dart';

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
      analyze(),
      closet(),
      myPage(),
    ];
    // final colorScheme = Theme.of(context).colorScheme;
    // final textTheme = Theme.of(context).textTheme;
// <<<<<<< Updated upstream
    return ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark_theme : light_theme,
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
                    icon: Icon(Icons.question_answer_outlined),
                  ),
                  BottomNavigationBarItem(
                    title: Text('analyze'),
                    icon: Icon(Icons.analytics),
                  ),
                  BottomNavigationBarItem(
                    title: Text('calendar'),
                    icon: Icon(Icons.calendar_today),
                  ),
                  BottomNavigationBarItem(
                    title: Text('My Page'),
                    icon: Icon(Icons.perm_identity),
                  ),
                ],
              ),
// =======
//     return MaterialApp(
//       home: Scaffold(
//         body: _children[_currentIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           currentIndex: _currentIndex,
//           //selectedItemColor: Theme.of(context).colorScheme.primary,
//           selectedItemColor: PrimaryColorLight,
//           //unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
//           unselectedItemColor: OnSecondaryLight,
//           selectedLabelStyle: Theme.of(context).textTheme.caption,
//           unselectedLabelStyle: Theme.of(context).textTheme.caption,
//           onTap: (value) {
//             // Respond to item press.
//             setState(() => _currentIndex = value);
//             print(_currentIndex);
//           },
//           items: [
//             BottomNavigationBarItem(
//               title: Text('Home'),
//               icon: Icon(Icons.home_outlined),
//             ),
//             BottomNavigationBarItem(
//               title: Text('With People'),
//               icon: Icon(Icons.grade_outlined),
//             ),
//             BottomNavigationBarItem(
//               title: Text('Favorite'),
//               icon: Icon(Icons.favorite_outline),
// >>>>>>> Stashed changes
            ),
            // theme: notifier.darkTheme ? dark, light,
          );
        }));
  }
}

// final ThemeData _closetTheme = _buildClosetTheme();
//
// ThemeData _buildClosetTheme() {
//   final ThemeData base = ThemeData.light();
//   return base.copyWith(
//     colorScheme: ColorScheme(
//       primary: PrimaryColorLight,
//       primaryVariant: PrimaryVariantLight,
//       secondary: SecondaryLight,
//       secondaryVariant: SecondaryVariantLight,
//       surface: SurfaceLight,
//       background: BackgroundLight,
//       error: ErrorLight,
//       onPrimary: OnPrimaryLight,
//       onSecondary: OnSecondaryLight,
//       onSurface: OnSurfaceLight,
//       onBackground: OnBackgroundLight,
//       onError: OnErrorLight,
//       brightness: Brightness.light,
//     ),
//     //
//   //     const PrimaryColorLight = Color(0xFF6200EE);
//   //     const PrimaryVariantLight = Color(0xFF3700B3);
//   // const SecondaryLight = Color(0xFF03DAC6);
//   // const SecondaryVariantLight = Color(0xFF018786);
//   // const BackgroundLight = Color(0xFFFFFFFF);
//   // const SurfaceLight = Color(0xFFFFFFFF);
//   // const ErrorLight = Color(0xFFB00020);
//   // const OnPrimaryLight = Color(0xFFFFFFFF);
//   // const OnSecondaryLight = Color(0xFF000000);
//   // const OnBackgroundLight = Color(0xFF000000);
//   // const OnSurfaceLight = Color(0xFF000000);
//   // const OnErrorLight = Color(0xFFFFFFFF);
//   //
//   // const PrimaryColorDark = Color(0xFFBB86FC);
//   // const PrimaryVariantDark = Color(0xFF3700B3);
//   // const SecondaryDark = Color(0xFF03DAC6);
//   // const SecondaryVariantDark = Color(0xFF03DAC6);
//   // const BackgroundDark = Color(0xFF121212);
//   // const SurfaceDark = Color(0xFF121212);
//   // const ErrorDark = Color(0xFFCF6679);
//   // const OnPrimaryDark = Color(0xFF000000);
//   // const OnSecondaryDark = Color(0xFF000000);
//   // const OnBackgroundDark = Color(0xFFFFFFFF);
//   // const OnSurfaceDark = Color(0xFFFFFFFF);
//   // const OnErrorDark = Color(0xFF000000);
//
//   //
//
//     // primaryIconTheme: base.iconTheme.copyWith(
//     //   color: closetPurple,
//     // ),
//   );
// }
//
