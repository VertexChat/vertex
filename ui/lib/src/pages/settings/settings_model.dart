/// Data model for Settings
///
/// Model -- MVC Pattern
class Settings {
  // Audio Settings
  String inputDevice;
  String outputDevice;
  int inputSensitivity = 5; // Start with 5, modify later

  // 3 Param Constructor
  Settings(this.inputDevice, this.outputDevice, this.inputSensitivity);
}