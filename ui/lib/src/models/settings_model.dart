/// Data model for Settings
///
/// Model -- MVC Pattern
class Settings {
  String audioInput; // Microphone
  String audioOutput; // Headphone
  double audioInputSensitivity; // Microphone sensitivity
  String videoInput; // Web cam
  bool audioInputIsMute; // Microphone mute?
  bool audioOutputIsMute; // Headphone mute?

  Settings({this.audioInput, this.audioOutput, this.audioInputSensitivity,
      this.videoInput, this.audioInputIsMute, this.audioOutputIsMute});
}