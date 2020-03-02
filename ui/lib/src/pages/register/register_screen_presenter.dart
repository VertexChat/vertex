import 'package:vertex_ui/src/services/client_stubs/lib/api.dart';

abstract class RegisterScreenContract {
  void onRegisterSuccess(User user);

  void onRegisterError(String errorTxt);
}

class RegisterScreenPresenter {
  RegisterScreenContract _view;
  var api = AuthApi();

  RegisterScreenPresenter(this._view);

  doRegister(User user) {
    api.register(user: user).then((user) {
      _view.onRegisterSuccess(user);
    }).catchError((Object error) {
      _view.onRegisterError(error.toString());
    });
  } //End doLogin function
} //End class
