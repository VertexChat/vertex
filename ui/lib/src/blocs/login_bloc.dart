import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:vertex_ui/src/utils/validator.dart';

/// Login bloc, BLoC stands for Business Logic Components.
/// Bloc in an application is where everything is represented as stream of events
/// In this case for the [LoginPage] & [RegisterPage] we are going to use [BaseBloc]
/// to stream our events. This is one method in flutter of breaking up the business
/// logic from the UI and updating application state.
///
/// The [username] & [password] fields are read in and validated using the
/// [Validators] class. Once validated [submitCheck] returns true to the [LoginPage]
/// using [Rx]
class LoginBloc extends Object with Validators implements BaseBloc {
  final _usernameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get usernameChanged => _usernameController.sink.add;

  Function(String) get passwordChanged => _passwordController.sink.add;

  Stream<String> get username =>
      _usernameController.stream.transform(validateUsername);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitCheck =>
      Rx.combineLatest2(username, password, (uname, pass) => true);

  submit() {
    // Submits inside a bloc class should not have any information about
    // navigation. You do not want to be doing platform dependent stuff inside the
    // here
  }

  @override
  void dispose() {
    _usernameController?.close();
    _passwordController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
