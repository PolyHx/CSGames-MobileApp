import 'package:PolyHxApp/components/loadingspinner.dart';
import 'package:PolyHxApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:PolyHxApp/components/pillbutton.dart';
import 'package:PolyHxApp/services/auth.service.dart';
import 'package:PolyHxApp/utils/routes.dart';

class LoginPage extends StatefulWidget {
  AuthService _authService;

  LoginPage(this._authService, {Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState(_authService);
}

class _LoginPageState extends State<LoginPage> {
  static const String LOGIN_FAILED_MESSAGE = 'Login failed.';
  final formKey = new GlobalKey<FormState>();
  AuthService _authService;
  String _email;
  String _password;
  String _loginFeedbackMessage = '';

  bool loading = false;

  _LoginPageState(this._authService);

  void _login() {
    setState(() => loading = true);
    formKey.currentState.save();
    _authService.login(_email, _password).then((loggedIn) {
      if (loggedIn && _authService.CurrentUser != null) {
        setState(() {
          _loginFeedbackMessage = '';
        });
        Navigator.of(context).pushNamed(Routes.HOME);
      }
      else {
        setState(() {
          _loginFeedbackMessage = LOGIN_FAILED_MESSAGE;
        });
      }
      setState(() => loading = false);
    });
  }

  Widget buildLoginForm() {
    return new Form(
      key: formKey,
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(bottom: 10.0, right: 10.0),
            child: new TextFormField(
              style: new TextStyle(color: Constants.POLYHX_GREY),
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                labelText: 'Email',
                icon: new Icon(Icons.person_outline, color: Constants.POLYHX_GREY),
              ),
              onSaved: (val) => _email = val,
            ),
          ),
          new Padding(
            padding: new EdgeInsets.only(bottom: 40.0, right: 10.0),
            child: new TextFormField(
              style: new TextStyle(color: Constants.POLYHX_GREY),
              decoration: new InputDecoration(
                  labelText: 'Password',
                  icon: new Icon(Icons.lock_outline, color: Constants.POLYHX_GREY)),
              onSaved: (val) => _password = val,
              obscureText: true,
            ),
          ),
          new PillButton(
            text: 'Login',
            textColor: Colors.white,
            onPressed: _login,
            enabled: !loading,
          ),
          new Padding(
              padding: new EdgeInsets.only(top: 20.0),
              child: new Text(
                _loginFeedbackMessage,
                style: new TextStyle(color: Colors.red, fontSize: 16.0),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Constants.POLYHX_RED,
      body: new Center(
          child: new Material(
        elevation: 4.0,
        borderRadius: new BorderRadius.circular(5.0),
        color: Colors.transparent,
        child: new Container(
          color: Colors.white,
          width: 330.0,
          height: 450.0,
          child: new Stack(
            children: <Widget>[
              new Container(
                  color: Colors.transparent,
                  margin: new EdgeInsets.all(15.0),
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset('assets/logo.png', fit: BoxFit.contain),
                        new Container(
                            width: 340.0,
                            child: buildLoginForm()),
                      ])),
              loading ? new LoadingSpinner() : new Container()
            ],
          ),
        ),
      )),
    );
  }
}
