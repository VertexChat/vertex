import 'package:flutter/material.dart';

import 'audio_detail_page.dart';
import 'audio_settings_model.dart';

/// AudioSettingsCard
/// Public
/// Stateful
class AudioSettingsCard extends StatefulWidget {
  final AudioSettings audioSettings;

  AudioSettingsCard(this.audioSettings);

  @override
  _AudioSettingsCardState createState() =>
      _AudioSettingsCardState(audioSettings);
}

/// _AudioSettingsCard
/// Private
/// Stateless
class _AudioSettingsCardState extends State<AudioSettingsCard> {
  AudioSettings audioSettings;

  _AudioSettingsCardState(this.audioSettings);

  showAudioDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AudioDetailPage(audioSettings);
    }));
  }

  Widget get audioSettingsCard {
    // New container needed .. modify height and width to better suit
    return Container(
      width: 400,
      height: 200,
      child: Card(
          color: Colors.black87,
          // Want to wrap children .. give padding
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 64.0,
            ),
            child: Column(
              // Alignment properties similar to CSS flexbox properties
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Input Device: " + widget.audioSettings.input_device,
                    style: Theme.of(context).textTheme.headline),
                Text("Output Device: " + widget.audioSettings.ouput_device,
                    style: Theme.of(context).textTheme.headline),
                Text(
                    "Input Sensitivity: " +
                        '${widget.audioSettings.input_sensitivity} / 100',
                    style: Theme.of(context).textTheme.headline),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showAudioDetailPage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
            height: 200.0,
            width: 600.0,
            child: Stack(
              children: <Widget>[
                Positioned(left: 50.0, child: audioSettingsCard),
              ],
            )),
      ),
    );
  }
}
