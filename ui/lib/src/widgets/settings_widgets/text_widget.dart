import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text; // Display Text

  TextWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            text,
            style: Theme.of(context).textTheme.title,
            minFontSize: 11.0,
          ),
        ],
      ),
    );
  } //End builder
} //End class
