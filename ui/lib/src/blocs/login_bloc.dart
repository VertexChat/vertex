import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:vertex_ui/src/utils/validator.dart';

class LoginBloc extends Object with Validators implements BaseBloc {
  final _usernameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get usernameChanged => _usernameController.sink.add;

  Function(String) get passwordChanged => _passwordController.sink.add;

  Stream<String> get username =>
      _usernameController.stream.transform(validateUsername);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitCheck => Rx.combineLatest2(username, password, (uname, pass) => true);

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
