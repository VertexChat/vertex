import 'dart:async';

/// Class that define validators for login and register forms

class Validators {
  // Validate display name:
  var validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length == 0)
      sink.addError("Display name is Required");
    else
      sink.add(name);
  });

  // Validate username:
  var validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
      String pattern = r'(^[a-zA-Z0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (username.length == 0)
      sink.addError("Username is Required");
    else if (!regExp.hasMatch(username))
      sink.addError("Name must be a-z and A-Z");
    else
      sink.add(username);
  });

//https://stackoverflow.com/questions/56253787/how-to-handle-textfield-validation-in-password-in-flutter
  var validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);

    if (password.isEmpty)
      sink.addError('Please enter password');
    else {
      if (!regex.hasMatch(password))
        sink.addError(
            'Enter valid password.\nMust contain at least one upper case,\nOne '
            'lower case,\nOne digit and one special character');
      else
        sink.add(password);
    } //End if else
  }); //End validate password function
} //End class
