import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:vertex_ui/src/pages/home_page.dart';
import 'package:vertex_ui/src/widgets/custom_gradient.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // https://www.youtube.com/watch?v=FNBuo-7zg2Q&feature=youtu.be
  @override
  void initState() {
    super.initState();
//    Timer(Duration(seconds: 5), () => UI());
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                VertexHomePage(title: 'Welcome Home'))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: getCustomGradient(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 100.0,
                        child: Icon(
                          Icons.donut_small,
                          color: Colors.black87,
                          size: 100.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Vertex",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                  LinearProgressIndicator(
//                    backgroundColor: Colors.black87,
//                  ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.black87,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
