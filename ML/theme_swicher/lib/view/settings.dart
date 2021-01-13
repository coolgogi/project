import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Theme Switcher"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SwitchListTile(
                  title: Text("Dark Mode"),
                  onChanged: (value) {},
                  value: false,
                ),
                Card(
                  child: ListTile(
                    title: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                  ),
                ),
              ]),
        ));
  }
}
