import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MaterialApp(
    title: 'SharedPreferences',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enteredDataField = new TextEditingController();
  String _savedData = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSavedData();
  }
  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if(preferences.getString('data') != null && preferences.getString('data').isNotEmpty) {
        _savedData = preferences.getString('data');
      }
      else {
        _savedData = "Empty Shared Preferences";
      }
    });
  }

  _saveMessage(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message); // Key:value
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shared Prefs'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: new Container(
        padding: const EdgeInsets.all(20.4),
        alignment: Alignment.topCenter,
        child: new ListTile(
          title: new TextField(
            controller: _enteredDataField,
            decoration: new InputDecoration(labelText: 'Write Something'),
          ),
          subtitle: new FlatButton(
              onPressed: () {
            //save to file
                _saveMessage(_enteredDataField.text);
          },
              child: new Column(
                children: <Widget>[
                  new Text('Save Data'),
                  new Padding(padding: new EdgeInsets.all(25.5)),
                  new Text(_savedData),
                ],
              )),
        ),
      ),
    );
  }
}
