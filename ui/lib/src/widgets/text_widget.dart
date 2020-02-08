import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text; // Display Text

  TextWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 0,
//        color: Colors.white12,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 8.0,
            left: 20.0,
            right: 20.0
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              Text("$text: " + varText,
//                  style: Theme.of(context).textTheme.headline),
              Text(text, style: Theme.of(context).textTheme.headline),
            ],
          ),
        ),
      ),
    );
  }
}