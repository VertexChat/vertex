import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:vertex_ui/src/utils/validator.dart';

class RegistrationBloc extends Object with Validators implements BaseBloc {
  final _usernameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get usernameChanged => _usernameController.sink.add;

  Function(String) get passwordChanged => _passwordController.sink.add;

  Stream<String> get username =>
      _usernameController.stream.transform(validateUsername);

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  //https://pub.dev/packages/rxdart_codemod
  Stream<bool> get submitCheck =>
      Rx.combineLatest2(username, password, (uname, pass) => true);

  @override
  void dispose() {
    _usernameController?.close();
    _passwordController?.close();
  }
} //End class

abstract class BaseBloc {
  void dispose();
} //End class
