import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// This Widget is for creating a heading for the app drawer

class HeadingWidget extends StatelessWidget {
  final String headingText;

  const HeadingWidget({Key key, this.headingText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final data = MediaQuery.of(context).size
    return Container(
      padding: EdgeInsets.all(20.0),
      alignment: Alignment.center,
      child: AutoSizeText(headingText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    );
  } //End builder
} //End class
