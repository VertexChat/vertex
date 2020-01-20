/// Audio Settings
/// MVC Pattern
class AudioSettings {
  final String input_device;
  final String ouput_device;
  int input_sensitivity = 50; // Start at 50

  AudioSettings(this.input_device, this.ouput_device, this.input_sensitivity);
}