import 'package:flutter/material.dart';

import 'audio_settings_card.dart';
import 'audio_settings_model.dart';

/// Class builds the list of settings on settings page
class SettingsList extends StatelessWidget {
  final List<AudioSettings> audioSettings;

  SettingsList(this.audioSettings);

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: audioSettings.length,
      itemBuilder: (context, int) {
        return AudioSettingsCard(audioSettings[int]);
      },
    );
  }
}
