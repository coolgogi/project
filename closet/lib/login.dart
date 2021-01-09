import 'package:closet/helper/login_background.dart';
import 'package:closet/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/join_or_login.dart';
import 'forget_pw.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // 휴대폰 화면 크기 가져오기

    return Scaffold(
        //resizeToAvoidBottomInset : false,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CustomPaint(
              size: size,
              painter: LoginBackground(
                  isJoin: Provider.of<JoinOrLogin>(context).isJoin),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                  _logoImage,
                  Stack(
                    children: <Widget>[
                      _inputForm(size),
                      _loginButton(size),
                    ],
                  ),
                  Container(
                    height: size.height * 0.1,
                  ),
                  Consumer<JoinOrLogin>(
                    builder: (context, joinOrLogin, child) => GestureDetector(
                        onTap: () {
                          joinOrLogin.toggle();
                        },
                        child: Text(
                          joinOrLogin.isJoin
                              ? "Already Have an Account? Sign in"
                              : "Don't Have an Account? Create One",
                          style: TextStyle(
                              color: joinOrLogin.isJoin
                                  ? Colors.lightGreen
                                  : Colors.blue),
                        )),
                  ),
                  Container(
                    height: size.height * 0.05,
                  )
                ]),
              ),
            )
          ],
        ));
  }

  void _register(BuildContext context) async {
    final UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User user = result.user;

    if (user == null) {
      final snackBar = SnackBar(content: Text('Please try again later.'));
      Scaffold.of(context).showSnackBar(snackBar);
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  email: user.email,
                )));
  }

  void _login(BuildContext context) async {
    final UserCredential result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final User user = result.user;

    if (user == null) {
      final snackBar = SnackBar(content: Text('Please try again later.'));
      Scaffold.of(context).showSnackBar(snackBar);
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  email: user.email,
                )));
  }

  Widget get _logoImage => Expanded(
        // 아래에서부터 차곡차곡 쌓이고 남은 공간을 확장해서 다 차지함
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(backgroundImage: AssetImage("assets/1LMu.gif")),
          ),
        ),
      );

  Widget _loginButton(Size size) {
    return Positioned(
      left: size.width * 0.15,
      right: size.width * 0.15,
      bottom: 0,
      child: SizedBox(
        height: 50,
        child: Consumer<JoinOrLogin>(
          builder: (context, joinOrLogin, child) => RaisedButton(
              child: Text(
                joinOrLogin.isJoin ? "Join" : "Login",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: joinOrLogin.isJoin ? Colors.lightGreen : Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  joinOrLogin.isJoin ? _register(context) : _login(context);
                }
              }),
        ),
      ),
    );
  }

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 12, top: 12, bottom: 32),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: "Password",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please input correct password";
                      }
                      return null;
                    },
                  ), //input값이 잘 작성됐는지 확인해줌
                  Container(
                    height: 8,
                  ),
                  Consumer<JoinOrLogin>(
                    builder: (context, joinOrLogin, child) => Opacity(
                        opacity: joinOrLogin.isJoin ? 0 : 1,
                        child: GestureDetector(
                            onTap: joinOrLogin.isJoin
                                ? null
                                : () {
                                    goToForgetPw(context);
                                  },
                            child: Text("Forgot Password"))),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  goToForgetPw(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgetPw()));
  }
}
