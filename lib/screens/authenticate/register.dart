import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/constant.dart';
import 'package:flutter_firebase/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return _loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Sign In")),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            SizedBox(height: 20),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText : "Email"),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
              validator: (val) => val.isEmpty ? "Enter an email" : null,
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: "Password"),
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
              obscureText: true,
              validator: (val) => val.length < 6 ? "Enter the password 6+ long char" : null,
            ),
            SizedBox(height: 20),
            RaisedButton(
              color: Colors.pink,
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    _loading = true;
                  });
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() {
                      _loading = false;
                      error = "please supply a valid email";
                    });
                  }
                }
              },
            ),
            SizedBox(
              height: 12),
              Text(error, style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ]),
        ),
      ),
    );
  }
}
