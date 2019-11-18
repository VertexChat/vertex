import 'package:flutter/material.dart';

/// Call to run App Root (App starts here)
void main() => runApp(Vertex_UI()); // Vertex_UI -> App root call to

/// App Root
class Vertex_UI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertex',
      theme: ThemeData(
        /// App theme-ing here
        primarySwatch: Colors.blue,
      ),
      home: VertexLanding(landingTitle: 'Vertex Landing Page'),

      /// Change this to splash-screen
      /// Landing screen should come later after Login
    );
  }
}

/// Each class defined below here is now a part of the App Root node
/// VertexLanding is currently main landing page, meaning the App will
/// load to that page.
/// Stateful class --> Stateful widget.
class VertexLanding extends StatefulWidget {
  /// Home page of application.
  /// Fields in Widget subclass always marked final

  VertexLanding({Key key, this.landingTitle}) : super(key: key);

  final String landingTitle;

  @override
  _VertexLandingState createState() => _VertexLandingState();
}

/// Stateless class
class _VertexLandingState extends State<VertexLanding> {
  int _counter = 0;

  /// Debugging variable used for counter

  /// Debugging method used for initial setup of Flutter
  void _incrementCounter() {
    /// setState calls build method below
    setState(() {
      _counter++;
    });
  }

  /// Build is run and rerun every time above method, setState, is called
  @override
  Widget build(BuildContext context) {
    /// Scaffold: framework which implements the basic material
    /// design visual layout structure of the flutter app.
    return Scaffold(
      appBar: AppBar(
        /// Setting AppBar title here
        title: Text(widget.landingTitle),
      ),

      /// Center: A widget that centers its child within itself
      body: Center(
        /// Column: A Column is a widget used to display child widgets in a vertical manner.
        /// We can update this to be whatever we like.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
