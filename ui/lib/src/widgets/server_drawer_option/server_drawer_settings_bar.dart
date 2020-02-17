import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Drawer settings class that returns a widget with buttons that allow
/// the user to mute there mic, headset or navigate into settings
/// TODO: Complete settings integration

class ServerDrawerSettingsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: BottomNavigationBar(
            backgroundColor: Colors.black12,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: null, //TODO: Implement navigation to settings page
                  icon: Icon(Icons.mic),
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: null, //TODO: Implement navigation to settings page
                  icon: Icon(Icons.headset),
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: null, //TODO: Implement navigation to settings page
                  icon: Icon(Icons.settings),
                ),
                title: Text(''),
              ),
            ]),
      ),
    );
  } //End widget builder
} //End class