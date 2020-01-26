import 'package:flutter/material.dart';

// TODO: Make this class work

class DropBoxWidget extends StatefulWidget {
  final String _value; // Value Store
  final List<String> options;

  DropBoxWidget(this._value, this.options);

  @override
  _DropBoxWidgetState createState() => _DropBoxWidgetState(_value, options);
}

class _DropBoxWidgetState extends State<DropBoxWidget> {
  String _defaultValue;
  List<String> options;

  _DropBoxWidgetState(this._defaultValue, this.options);

  @override
  Widget build(BuildContext context) {
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
                    value: _defaultValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.lightGreen[800]),
                    underline: Container(
                      height: 2,
                      color: Colors.lightGreen,
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _defaultValue = value;
                      });
                    },
                    // TODO: Look at getting audio options here
                    items: <String>[
                      'None Selected',
                      '$options[0]',
                      '$options[1]',
                    ].map((String value) {
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
}