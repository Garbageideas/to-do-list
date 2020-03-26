import 'package:flutter/material.dart';
import 'package:to_do_list/firebase/auth.dart';
import 'package:to_do_list/overview/routes.dart';
import 'package:to_do_list/overview/theme.dart';
import 'package:to_do_list/models/login_details.dart';

class HomeScreen extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BaseAuth auth = Auth();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailBoxController;
  TextEditingController _passwordBoxController;

  @override
  void initState() {
    _emailBoxController = TextEditingController(text: 'guest');
    _passwordBoxController = TextEditingController(text: 'guest');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Row(
          children: [
            Icon(Icons.done_all, color: Colors.white),
            Text(
              'Garbageideas Todolist',
              style: TextStyle(color: Colors.white),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );

    TextFormField email = TextFormField(
      controller: _emailBoxController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    TextFormField password = TextFormField(
      controller: _passwordBoxController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          if (_emailBoxController.text.trim() == "" ||
              _passwordBoxController.text.trim() == "") {
            _showSnackBar("User and  Password cannot be empty");
            return;
          }

          // TODO : id & pass, regex filtering needed.
          // var result = auth.signUp(_emailBoxController.text, _passwordBoxController.text);
          // if (result == true)

          if (LoginDetails.checkUser(_emailBoxController.text)) {
            if (LoginDetails.checkPass(
                _emailBoxController.text, _passwordBoxController.text)) {
              Navigator.of(context).pushNamed(ScreenRoutes.inbox);
            } else {
              _showSnackBar("Incorrect Password");
            }
          } else {
            _showSnackBar("User Does not Exist");
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.white,
        elevation: ProtoTheme.elevationLayerOne,
        child: Text('Log In', style: TextStyle(color: Colors.black)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: ProtoTheme.yellow),
      ),
      onPressed: () => _showSnackBar('It`s not support yet.'),
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ProtoTheme.purple,
      body: Builder(builder: (conxtext) {
        return Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
              forgotLabel,
            ],
          ),
        );
      }),
    );
  }

  _showSnackBar(String message) =>
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
}
