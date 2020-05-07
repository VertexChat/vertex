import 'package:openapi/api.dart';
import 'package:vertex_ui/src/pages/register/register_page.dart';
import 'package:vertex_ui/src/routing/route_names.dart';

abstract class RegisterScreenContract {
  void onRegisterSuccess(InlineObject user);

  void onRegisterError(String errorTxt);
}

/// Class handles making register request to the sever passing [InlineObject].
/// If a register is successful the view state is updated by calling
/// [_view.onRegisterSuccess], this will notify the [RegisterPage] to navigate
/// to [LoginRoute].

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
