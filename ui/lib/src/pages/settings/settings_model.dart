/// Data model for Settings
///
/// Model -- MVC Pattern
class Settings {
  // Audio Settings
  String inputDevice;
  String outputDevice;
  double inputSensitivity;

  // 3 Param Constructor
  Settings(this.inputDevice, this.outputDevice, this.inputSensitivity);
}