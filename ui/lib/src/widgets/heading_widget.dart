import 'package:flutter/cupertino.dart';

/// This Widget is for creating a heading for the app drawer

class HeadingWidget extends StatelessWidget {
  final String headingText;

  const HeadingWidget({Key key, this.headingText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0, bottom: 10.0),
      alignment: Alignment.center,
      child: Text(headingText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    );
  } //End builder
} //End class
