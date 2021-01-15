import 'package:closet/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'data/join_or_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Splash());
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return ChangeNotifierProvider<JoinOrLogin>.value(
              value: JoinOrLogin(),
              child: MyApp(),
            );
          } else {
            return HomePage(email: snapshot.data.email);
          }
        });
  }
}
