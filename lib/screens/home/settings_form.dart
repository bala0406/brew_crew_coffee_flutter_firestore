import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:flutter_firebase/shared/constant.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> sugars = ["0", "1", "2", "3", "4"];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Text("Update your brew settings", style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData.name ,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? "Please Enter a name" : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  items: sugars.map((sugar) => DropdownMenuItem(value: sugar, child: Text("$sugar sugars"))).toList(),
                  onChanged: (val) => setState(() => _currentSugar = val),
                  value: _currentSugar ?? "0",
                  decoration: textInputDecoration,
                ),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  onChanged: (val) => setState(() => _currentStrength = val.round()),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                ),
                RaisedButton(
                  color: Colors.pink,
                  child: Text(
                    "update",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugar ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }

                  },
                )
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
