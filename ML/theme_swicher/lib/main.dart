import 'package:flutter/material.dart';
import 'package:theme_swicher/view/settings.dart';
import 'package:theme_swicher/services/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, notifier, child) => SwitchListTile(
          title: Text("Dark Mode"),
          onChanged: (value) {
            notifier.toggleTheme();
          },
          value: notifier.darkTheme,
        ),
      ),
    );
  }
}
