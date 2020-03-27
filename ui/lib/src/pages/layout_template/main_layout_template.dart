import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

/// Layout template class that will allow for navigation of pages within a UI element
/// like a Container() or it can be used at the root of the application as well
/// if a main layout is implemented with a navbar
/// For the use case of this application it will be used with the home page to allow
/// page changes inside the Expanded(Container()). This will allow for changing between
/// text messaging and in-call page

class MainLayoutTemplate extends StatelessWidget {
  final Widget child; // Child view
  const MainLayoutTemplate({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) => Scaffold(
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: child,
                  )
                ],
              ),
            ));
  } //End builder
} //End class
