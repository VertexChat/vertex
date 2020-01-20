// AudioDetailPage

import 'package:flutter/material.dart';
import 'audio_settings_model.dart';

class AudioDetailPage extends StatefulWidget {
  final AudioSettings audioSettings;

  AudioDetailPage(this.audioSettings);

  @override
  _AudioDetailPageState createState() => _AudioDetailPageState();
}

class _AudioDetailPageState extends State<AudioDetailPage> {
  String _inputValue = "None Selected"; //TODO
  String _outputValue = "None Selected"; //TODO

  double _sliderValue = 50.0;

  /// Widget which shows the audio sensitivity
  Widget get inputSensitivity {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
            'Input Sensitivity' +
                '${widget.audioSettings.input_sensitivity} / 100',
            style: Theme.of(context).textTheme.display2),
      ],
    );
  }

  Widget get updateInputSensitivity {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Use Flexible to expand as much as it can until
              // all space is taken up.
              Flexible(
                flex: 1,
                // Slider workflow:
                // 1. User drags the slider.
                // 2. onChanged is called.
                // 3. The callback in onChanged sets the sliderValue state.
                // 4. Flutter repaints everything that relies on sliderValue,
                // in this case, just the slider at its new value.
                child: Slider(
                  activeColor: Colors.blueGrey,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newInputSensitivity) {
                    setState(() => _sliderValue = newInputSensitivity);
                  },
                  value: _sliderValue,
                ),
              ),

              // Display value of slider
              Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text(
                  '${_sliderValue.toInt()}',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ],
          ),
        ),
        submitButton,
      ],
    );
  }

  /// Submit button
  Widget get submitButton {
    return RaisedButton(
      onPressed: () => updateValues(),
      color: Colors.blueGrey,
    );
  }

  void updateValues() {
    setState(() => widget.audioSettings.input_sensitivity = _sliderValue.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Audio Settings'),
      ),
      body: ListView(
        children: <Widget>[inputSensitivity,updateInputSensitivity],
      )
    );
  }
}
