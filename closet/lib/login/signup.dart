import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
              validator: (value){
                if (value.isEmpty) {
                  return 'Please enter Username';
                }
                return null;
              },

            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (value){
                if (value.isEmpty) {
                  return 'Please enter Password';
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _confirmController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Confirm Password',
              ),
              obscureText: true,
              validator: (value){
                if (value.isEmpty) {
                  return 'Please enter Confirm Password';
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email Address',
              ),
              validator: (value){
                if (value.isEmpty) {
                  return 'Please enter Email Address';
                }
                return null;
              },
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('SIGN UP'),
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

