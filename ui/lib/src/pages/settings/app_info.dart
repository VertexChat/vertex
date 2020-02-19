import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

/// Class which gets information about the app current build number and version
/// and builds a column that can display the information within the Settings UI
/// Imported package called `package_info` to achieve this

class AppInfo extends StatefulWidget {
  AppInfo({Key key}) : super(key: key);

  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  //Variables
  PackageInfo _packageInfo;
  String _versionName;
  String _buildCode;
  bool isWeb = false;

  Future<void> fetchPackageInfo() async {
    if (kIsWeb) {
      isWeb = true;
      return;
    } else {
      _packageInfo = await PackageInfo.fromPlatform();
      _versionName = _packageInfo.version;
      _buildCode = _packageInfo.buildNumber;
    } // end if else
  } //Enf function

  @override
  void initState() {
    super.initState();
    fetchPackageInfo();
  } //End Function

  @override
  Widget build(BuildContext context) {
    if (isWeb) {
      return Text(" ");
    } else {
      if (_packageInfo != null) {
        return Column(
          children: <Widget>[
            Divider(
              thickness: 3,
              color: Colors.grey,
            ),
            Text(
              "App Info",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text("Version",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text(_versionName),
            ),
            ListTile(
                title: Text("Build Number",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(_buildCode)),
          ],
        );
      } else {
        //Loading info
        return CircularProgressIndicator();
      }
    } //end if else
  } //End builder
} //End class
