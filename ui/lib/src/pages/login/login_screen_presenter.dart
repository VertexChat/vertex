import 'package:openapi/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(InlineObject login);

  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  var api = AccountApi();
  var userApi = UserApi();
  List<User> _userList;

  LoginScreenPresenter(this._view);

  /// Function makes a login request to the sever passing [InlineObject].
  /// If a login is successful, the user accounts are query on the server
  /// to find the user details and save them using [SharedPreferences] to they
  /// can be used though out the application while logged in.
  /// TODO - Look into removing on logout.
  doLogin(InlineObject login) {
    api.login(login).then((value) async {
      _userList = await userApi.getUsers();
      final userDetails = await SharedPreferences.getInstance();

      //Check list of objects for object with field .username = to login.user,
      // the user name used to login.
      List<User> temp = _userList
          .where((user) => user.name
              .toLowerCase()
              .contains(login.username.toLowerCase()))
          .toList();

      if (temp != null) {
        // Set details
        userDetails.setInt('id', temp[0].id);
        userDetails.setString('username', temp[0].name);
      }
      _view.onLoginSuccess(value);
    }).catchError((Object error) {
      _view.onLoginError(error.toString());
    });
  } //End doLogin function
} //End class
