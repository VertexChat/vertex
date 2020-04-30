import 'package:flutter/material.dart';

/// Function that will display a [AlertDialog] if
/// any exceptions are throw by the application.
/// Requires [Exception]

class ExceptionAlertDialog extends StatelessWidget {
  final Exception exception;

  const ExceptionAlertDialog({Key key, @required this.exception});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Expection"),
      content: new Text(exception.toString()),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  } //end builder
} //End class
