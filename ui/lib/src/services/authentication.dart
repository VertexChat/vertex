import 'package:openapi/api.dart';

//Enum
enum AuthState { LOGGED_IN, LOGGED_OUT }

/// abstracted class that another class can implemented to subscribe to AuthState
abstract class AuthStateListener {
  void onAuthStateChanged(AuthState state);
}

/// This class defines a broadcaster/observable object that can notify subscribers of changes that
/// will happen in in terms of logged_in or logged_out.
/// Using Darts inbuilt factory constructor this allows for easy creation of a singleton
/// Ref: https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart
/// Observer/Subscriber Pattern


class AuthStateProvider {
  //Variables
  static final AuthStateProvider _instance = new AuthStateProvider.internal();
  // Factory Constructor
  List<AuthStateListener> _subscribers;
  factory AuthStateProvider() => _instance;

  AuthStateProvider.internal() {
    _subscribers = new List<AuthStateListener>();
    initState();
  }

  void initState() async {
    var api = AccountApi();
    var isLoggedIn = api.isLoggedIn;

    if (isLoggedIn)
      notify(AuthState.LOGGED_IN);
    else
      notify(AuthState.LOGGED_OUT);
  }

  void subscribe(AuthStateListener listener) {
    _subscribers.add(listener);
  }

  void dispose(AuthStateListener listener) {
    for (var l in _subscribers) {
      if (l == listener) _subscribers.remove(l);
    }
  }

  void notify(AuthState state) {
    print(state);
    _subscribers.forEach((AuthStateListener s) => s.onAuthStateChanged(state));
  }
} //End class

