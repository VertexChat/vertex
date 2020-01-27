//import 'package:flutter/material.dart';
//
//class DropBoxWidget extends StatelessWidget {
//
//  @override
//  _DropBoxWidgetState createState() => _DropBoxWidgetState();
//}
//
//class _DropBoxWidgetState extends State<DropBoxWidget> {
//  String defaultValue;
//  List<String> options;
//
//  _DropBoxWidgetState({this.defaultValue, this.options});
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Container(
//            padding: EdgeInsets.symmetric(
//              vertical: 16.0,
//              horizontal: 16.0,
//            ),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Flexible(
//                  flex: 1,
//                  child: DropdownButton<String>(
//                    value: defaultValue,
//                    icon: Icon(Icons.arrow_downward),
//                    iconSize: 24,
//                    elevation: 16,
//                    style: TextStyle(color: Colors.lightGreen[800]),
//                    underline: Container(
//                      height: 2,
//                      color: Colors.lightGreen,
//                    ),
//                    onChanged: (String value) {
//                      setState(() {
//                        defaultValue = value;
//                      });
//                    },
//                    // TODO: Look at getting audio options here
//                    items: options.map((String value) {
//                      return new DropdownMenuItem<String>(
//                        value: value,
//                        child: new Text(value),
//                      );
//                    }).toList(),
//                  ),
//                ),
//              ],
//            )),
//      ],
//    );
//  }
//}

import 'package:flutter/material.dart';

class DropBoxWidget extends StatelessWidget {
  String defaultValue;
  final List<String> options;

  DropBoxWidget(this.defaultValue, this.options);

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
                    value: defaultValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.lightGreen[800]),
                    underline: Container(
                      height: 2,
                      color: Colors.lightGreen,
                    ),
                    onChanged: (String value) {
                      defaultValue = value;
                    },
                    // TODO: Look at getting audio options here
                    items: options.map((String value) {
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