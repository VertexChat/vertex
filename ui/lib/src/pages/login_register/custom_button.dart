import 'package:flutter/material.dart';
import 'package:vertex_ui/src/pages/login_register/custom_button_model.dart';

// Class that displays icons of service a user can sign up with or login with.
// https://stackoverflow.com/questions/56245553/flutter-change-the-parameter-passed-to-a-statefulwidget
// https://stackoverflow.com/questions/53659570/how-to-pass-parameters-to-widgets-in-flutter
class CustomButton extends StatefulWidget {
  //Member Variables
  final ButtonModel buttonModel; // Declaring "buttonModel"

  CustomButton({this.buttonModel}); // Initializing "buttonModel"

  _CustomButton createState() => _CustomButton(this.buttonModel);
}

class _CustomButton extends State<CustomButton> {
  // Declaring "buttonModel"
  ButtonModel buttonModel;

  // Initializing "buttonModel"
  _CustomButton(this.buttonModel);

  @override
  Widget build(BuildContext context) {
    return new Material(
      borderRadius: BorderRadius.circular(20.0),
      shadowColor: Colors.greenAccent,
      color: buttonModel.buttonColor,
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          //Navigate ot register page
          Navigator.push(
            context,
            buttonModel.pageToOpen,
          );
        },
        child: Center(
          child: Text(buttonModel.buttonDisplayName,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
        ),
      ),
    );
  } //End widget builder

  validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
} //End class
