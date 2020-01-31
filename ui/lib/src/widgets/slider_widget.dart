import 'package:flutter/material.dart';

/// TODO: This class is probably not needed...
class SliderWidget extends StatefulWidget {
  final double sliderValue;

  const SliderWidget(this.sliderValue, {Key key}) : super(key: key);

  _SliderWidget createState() => _SliderWidget(this.sliderValue);
}

class _SliderWidget extends State<SliderWidget> {
  double _sliderValue;

  _SliderWidget(this._sliderValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Slider(
              activeColor: Colors.white,
              min: 0.0,
              max: 100.0,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
              value: _sliderValue,
            ),
          ),
        ],
      ),
    );
  }
}
