import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text; // Display Text
  final String varText; // Variable Text

  TextWidget(this.text, this.varText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.lightGreen[800],
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 8.0,
            left: 20.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("$text: " + varText,
                  style: Theme.of(context).textTheme.headline),
            ],
          ),
        ),
      ),
    );
  }
}