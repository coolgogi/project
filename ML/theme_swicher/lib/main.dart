import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings.dart';
import 'theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: "Flutter Provider",
            theme: notifier.darkTheme ? dark : light,
            home: SettingsPage(),
          );
        },
      ),
    );
  }
}
