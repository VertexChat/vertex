
import 'package:openapi/api.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(InlineObject login);

  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  var api = AccountApi();

  LoginScreenPresenter(this._view);

  doLogin(InlineObject login) {
    print(login);
    api.login(login).then((login) {
      _view.onLoginSuccess(login);
    }).catchError((Object error) {
      _view.onLoginError(error.toString());
    });
  } //End doLogin function
} //End class
