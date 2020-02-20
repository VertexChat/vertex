import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Class which gets information about the device it is currently on about and builds
/// a column that can display the information within the Settings UI
/// Imported package called `device_info` to achieve this

class DeviceInfo extends StatefulWidget {
  DeviceInfo({Key key}) : super(key: key);

  @override
  _DeviceInfoState createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  //Variables
  DeviceInfoPlugin _deviceInfo;
  AndroidDeviceInfo _androidInfo;
  IosDeviceInfo _iosDeviceInfo;
  bool _isWeb = false;

  Future _fetchDeviceInfo() async {
    _deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      // App is running on the web
      // This is needed as a user can resize the webpage and the UI will scale for mobile
      // causing this class to look for mobile platform information
      _isWeb = true;
      return;
    }
  } //End function

  @override
  void initState() {
    super.initState();
    _fetchDeviceInfo();
  } //End function

  Widget _getDeviceLayout() {
    if (_isWeb) {
      return ListTile(
        leading: Icon(Icons.web),
        title: Text("Applcation is running on a webrower"),
      );
    } else {
      return Column(
        children: <Widget>[
          ListTile(
            leading: Platform.isAndroid
                ? Icon(Icons.android)
                : Icon(FontAwesomeIcons.apple),
            title:
                Text("Platform", style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Platform.isAndroid
                ? Text(_androidInfo.device)
                : Text(_iosDeviceInfo.name),
          ),
          ListTile(
            title: Text("OS", style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Platform.isAndroid
                ? Text(_androidInfo.version.toString())
                : Text(_iosDeviceInfo.name),
          ),
        ],
      );
    } //end if else
  } //End get widget function

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AndroidDeviceInfo>(
        future: _deviceInfo.androidInfo,
        builder:
            (BuildContext context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // data loaded:
            _androidInfo = snapshot.data;
            return Column(
              children: <Widget>[
                Divider(
                  thickness: 3,
                  color: Colors.grey,
                ),
                Text(
                  "Device Info",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _getDeviceLayout(),
              ],
            );
          } //End if else
        });
  } //End builder
} //End class
