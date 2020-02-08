// ExampleDataScreen
// https://www.youtube.com/watch?v=QxE-hEa16gA&feature=youtu.be
// https://github.com/iampawan/flutter_connectivity
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ExampleDataScreen extends StatefulWidget {
  @override
  _ExampleDataScreenState createState() => new _ExampleDataScreenState();
}

class _ExampleDataScreenState extends State<ExampleDataScreen> {
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;

  // Listen for change in network
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      print(_connectionStatus);
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // Destroy subscription
    subscription.cancel();
    super.dispose();
  }

  Future getData() async {
    // TODO: API Call Here
    http.Response response =
        await http.get("https://jsonplaceholder.typicode.com/posts/");
    if (response.statusCode == HttpStatus.OK) {
      var result = jsonDecode(response.body);
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Connectivy")),
      body: new FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var myData = snapshot.data;
            return new ListView.builder(
              itemBuilder: (context, i) => new ListTile(
                title: Text(myData[i]['title']),
                // subtitle: Text(mydata[i]['body']),
              ),
              itemCount: myData.length,
            );
          } else {
            return Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
