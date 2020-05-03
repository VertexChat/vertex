import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

/// Function that will display a [AlertDialog] if
/// any errors occur during posting the new [Channel]
/// Requires [ApiException]

class ApiExceptionAlertDialog extends StatelessWidget {
  final ApiException apiException;

  const ApiExceptionAlertDialog({Key key, @required this.apiException});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> parsedError =
        json.decode(apiException.message.toString());

    return AlertDialog(
      title: new Text("Request Error"),
      content: new Text(parsedError['messages']),
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
