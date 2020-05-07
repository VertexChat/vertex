import 'package:openapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vertex_ui/src/pages/login/login_page.dart';
import 'package:vertex_ui/src/routing/route_names.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(InlineObject login);

  void onLoginError(String errorTxt);
}

/// Class handles making login request to the sever passing [InlineObject].
/// If a login is successful, the user accounts are query on the server
/// to find the user details and save them using [SharedPreferences] to they
/// can be used though out the application while logged in. The view state is updated
/// by calling [_view.onLoginSuccess], this will notify the [LoginPage] to navigate
/// to [HomeRoute].

class LoginScreenPresenter {
  LoginScreenContract _view;
  var api = AccountApi();
  var userApi = UserApi();
  List<User> _userList;

  LoginScreenPresenter(this._view);

  doLogin(InlineObject login) {
    api.login(login).then((value) async {
      _userList = await userApi.getUsers();
      final userDetails = await SharedPreferences.getInstance();

      //Check list of objects for object with field .username = to login.user,
      // the user name used to login.
      List<User> temp = _userList
          .where((user) =>
              user.name.toLowerCase().contains(login.username.toLowerCase()))
          .toList();

      if (temp != null) {
        // Set details
        userDetails.setInt('id', temp[0].id);
        userDetails.setString('username', temp[0].name);
      }
      _view.onLoginSuccess(value);
    }).catchError((error) {
//      Map<String, dynamic> parsedError = json.decode(error.message.toString());
      _view.onLoginError(error.toString());
    });
  } //End doLogin function
} //End class
