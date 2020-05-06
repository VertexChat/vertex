import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

/// This class returns a rendered [Widget] that is passed to it
/// inside the main class

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
