import 'package:closet/google_sign_in.dart';
import 'package:closet/helper/login_background.dart';
import 'package:closet/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/join_or_login.dart';
import 'forget_pw.dart';
import 'google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

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
          painter:
              LoginBackground(isJoin: Provider.of<JoinOrLogin>(context).isJoin),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _logoImage,
                  Stack(
                    children: <Widget>[
                      _inputForm(size),
                      _loginButton(size),
                    ],
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(size.height * 0.025),
                    child: _googleSignInButton(size, context),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(size.height * 0.025),
                    child: _facebookSignInButton(size, context),
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

  Widget _facebookSignInButton(Size size, BuildContext context) {
    return IconButton (
      splashColor: Colors.grey,
      onPressed: () async {
        await _signInWithFacebook(context);
        print("finish!!!!!!!!!!!!!!!");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(
        //       email: name,
        //     ),
        //   ),
        // );
      },
      icon: new Image.asset("assets/kakao_login_medium_narrow.png"),

    );
  }

  // Example code of how to sign in with Facebook.
  void _signInWithFacebook(BuildContext context) async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);
    try {
      final AuthCredential credential = FacebookAuthProvider.credential(
        result.accessToken.token,
      );
      final User user = (await _auth.signInWithCredential(credential)).user;

      print("Sign In ${user.uid} with Facebook");

    } catch (e) {
      print(e);
      print("Failed to sign in with Facebook: ${e}");

    }
  }


  void _register(BuildContext context) async {
    try {
      final UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      final User user = result.user;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                email: user.email,
              )));
    }
    catch (err) {
      final snackBar = SnackBar(content: Text('This email already exist.'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void _login(BuildContext context) async {
    try {
      final UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      final User user = result.user;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                email: user.email,
              )));
    }
    catch(err) {
      final snackBar = SnackBar(content: Text('Wrong email or password.'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _signInWithGoogle(BuildContext context) async {
    String name;
    String email;
    String imageUrl;

    try {
      print("1");
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      print("2");
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      print("3");
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      print("4");
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      print("5");
      final User currentUser = await _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print("6");
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      name = user.displayName;
      email = user.email;
      imageUrl = user.photoURL;

      print("7");
      Navigator.pushNamed(context, '/');
    }
    catch (err) {
      print("@@@error: $err");
      // final snackBar = SnackBar(content: Text('Error: Login failed.'));
      // Scaffold(
      //   body: Builder(
      //     builder: (context) => Scaffold.of(context).showSnackBar(snackBar);,
      //   ),
      // );

    }
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }


  Widget get _logoImage => Expanded(
        // 아래에서부터 차곡차곡 쌓이고 남은 공간을 확장해서 다 차지함
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/1LMu.gif"),
            ),
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

  Widget _googleSignInButton(Size size, BuildContext context) {
    return OutlineButton (
      splashColor: Colors.grey,
      onPressed: () async {
        await _signInWithGoogle(context);
        print("finish!!!!!!!!!!!!!!!");
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(
        //       email: name,
        //     ),
        //   ),
        // );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Sign in with Google",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
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







class facebookLogin extends StatefulWidget {
  @override
  _facebookLoginState createState() => new _facebookLoginState();
}

class _facebookLoginState extends State<facebookLogin> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';

  Future<Null> _login() async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_message),
              RaisedButton(
                onPressed: _login,
                child: Text('Log in'),
              ),
              RaisedButton(
                onPressed: _logOut,
                child: Text('Logout'),
              ),
            ],
          ),
        );

  }
}
