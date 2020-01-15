import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:vertex_ui/src/pages/settings/settings_list.dart';

import 'constants.dart';
import 'audio_settings_model.dart';
import 'audio_detail_page.dart';
import 'audio_settings_card.dart';

/// View -- MVC Pattern
class SettingsPage extends StatefulWidget {
    final String title;

    SettingsPage(this.title);

    @override
    _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends  State<SettingsPage>{
  List<AudioSettings> intialSettings = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SettingsList(intialSettings),
      )
    );
  }
}

/// Method for settings choices
void choiceAction(String choice) {
  if (choice == Constants.settings) {
    print("Settings");
  } else if (choice == Constants.subscribe) {
    print("Subscribe");
  } else if (choice == Constants.signOut) {
    print("SignOut");
  }
}
