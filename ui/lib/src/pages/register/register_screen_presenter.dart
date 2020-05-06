

import 'package:openapi/api.dart';

abstract class RegisterScreenContract {
  void onRegisterSuccess(InlineObject user);

  void onRegisterError(String errorTxt);
}

class RegisterScreenPresenter {
  RegisterScreenContract _view;
  var api = AccountApi();

  RegisterScreenPresenter(this._view);

  doRegister(InlineObject user) {
    api.register(user).then((user) {
      _view.onRegisterSuccess(user);
    }).catchError((Object error) {
      _view.onRegisterError(error.toString());
    });
  } //End doLogin function
} //End class
