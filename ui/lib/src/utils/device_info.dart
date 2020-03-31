import 'dart:io';

/// Class Return information about the device it is running on

class DeviceInfo {
  static String get label {
    return Platform.localHostname + '(' + Platform.operatingSystem + ")";
  }

  static String get userAgent {
    return 'flutter-webrtc/' + Platform.operatingSystem + '-plugin 0.0.1';
  }
}
