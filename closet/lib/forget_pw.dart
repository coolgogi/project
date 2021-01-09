import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPw extends StatefulWidget {
  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Proget Password"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
            TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: "Email",
            ),
            validator: (String value) {
              //input값이 잘 작성됐는지 확인해줌
              if (value.isEmpty) {
                return "Please input correct Email";
              }
              return null;
            },
          ),
              FlatButton(onPressed: () async {
                await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                //또는 FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text).whenComplete();
                final snackBar = SnackBar(
                    content: Text('Check  your email for password.'));
                Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
              }, child: Text("Reset Password"))
            ],
          ),
        ));
  }
}
