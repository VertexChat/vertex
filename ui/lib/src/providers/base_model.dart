import 'package:flutter/material.dart';
import 'package:vertex_ui/src/enums/view_state_enum.dart';

/// This class handles notify listens after a change has occurred related to them/
/// extends [ChangeNotifier]
///
/// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple

class BaseModel extends ChangeNotifier {
  //Variables
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  //Update the state and notify listeners
  void setState(ViewState viewState) {
    print(viewState);
    _state = viewState;
    notifyListeners();
  }
} //End class