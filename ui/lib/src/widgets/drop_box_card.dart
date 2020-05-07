import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DropBoxCard extends StatefulWidget {
  final String _dropBoxInput;
  final List<String> _dropBoxOption;

  DropBoxCard(this._dropBoxInput, this._dropBoxOption);
  @override
  _DropBoxCardState createState() =>
      _DropBoxCardState(this._dropBoxInput, this._dropBoxOption);
}

class _DropBoxCardState extends State<DropBoxCard> {
  String _dropBoxInput;
  List<String> _dropBoxOptions;

  _DropBoxCardState(this._dropBoxInput, this._dropBoxOptions);

  // https://codingwithjoe.com/flutter-saving-and-restoring-with-sharedpreferences/
  save(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPrefs.setBool(key, value);
    } else if (value is String) {
      sharedPrefs.setString(key, value);
    } else if (value is int) {
      sharedPrefs.setInt(key, value);
    } else if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPrefs.setStringList(key, value);
    }
  }

  Widget get audioInputDropBox {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: _dropBoxInput,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.white),
                    underline: Container(
                      height: 2,
                      color: Colors.white30,
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _dropBoxInput = value;
                      });
                      // Save as key value pair
                      save('audioInput', value);
                    },
                    items: _dropBoxOptions.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[audioInputDropBox],
        ),
      ),
    );
  }
}
