import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

/// Class which gets information about the app current build number and version
/// and builds a column that can display the information within the Settings UI
/// Imported package called `package_info` to achieve this
/// https://blog.maskys.com/how-to-get-the-version-build-number/

class AppInfo extends StatefulWidget {
  AppInfo({Key key}) : super(key: key);

  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  //Variables
  PackageInfo _packageInfo;
  String _versionName;
  String _buildNumber;
  bool isWeb = false;

  Future<String> _getVersionNumber() async {
    _packageInfo = await PackageInfo.fromPlatform();
    // Updated values and call setState to rebuild widget
    _versionName = _packageInfo.version;
    return _versionName;
  } //Enf function

  Future<String> _getBuildNumber() async {
    _packageInfo = await PackageInfo.fromPlatform();
    // Updated values and call setState to rebuild widget
    _buildNumber = _packageInfo.buildNumber;
    return _buildNumber;
  } //Enf function

  @override
  void initState() {
    super.initState();
  } //End Function

  @override
  Widget build(BuildContext context) {
    if (isWeb) {
      return Text(" ");
    } else {
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
            leading: Text("App Version Number",
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: FutureBuilder(
                future: _getVersionNumber(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) =>
                        Text(
                          snapshot.hasData ? snapshot.data : "Loading...",
                        ) // The widget using the data
                ),
          ),
          ListTile(
            leading: Text("Build Number",
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: FutureBuilder(
                future: _getBuildNumber(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) =>
                        Text(
                          snapshot.hasData ? snapshot.data : "Loading...",
                        ) // The widget using the data
                ),
          ),
        ],
      );
    } //End builder
  } //End class
} //End class
