import 'package:flutter/material.dart';

/// This Notify class is designed to aid in the process of updating listens
/// that a message has been received from the websocket that is connected to
/// the notification system running on the server. This will alert UI elements
/// that new data is needed from the database.

/// May need to look at adding http requests here to aids in the querying of data
/// to stop overhead

class NotifyModel extends ChangeNotifier {
  // Function that notify listens of a change
  void onChannelUpdate() {
    //tell the channels to pull from api
    // More data could be passed to aid with this
    notifyListeners();
  }

  void onMessageUpdate() {
    // tell message channel to pull from api
    notifyListeners();
  }
} //End class
