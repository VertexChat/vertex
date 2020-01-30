import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/services/api.dart';
import 'package:vertex_ui/src/widgets/icon_card.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Member Variables
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _key = GlobalKey<FormState>();
  bool _validate = false;
  String _uname, _displayName, _password;

  @override
  Widget build(BuildContext context) {
    //Data about the device the application is running on
    final data = MediaQuery.of(context);
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: data.size.height / 4,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 80.0, 0.0, 0.0),
                      child: AutoSizeText(
                        'Register',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              //Main register form container
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: new Form(
                  key: _key,
                  autovalidate: _validate,
                  child: FormUI(),
                ),
              ),
              SizedBox(height: data.size.height / 30.00),
              //Call IconCard Widget
              new IconCard()
            ]));
  } //end builder

  Widget FormUI() {
    //Data about the device the application is running on
    final data = MediaQuery.of(context);
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: InputDecoration(
              labelText: 'USERNAME',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green))),
          onSaved: (String val) {
            _uname = val;
          },
        ),
        SizedBox(height: data.size.height / 90),
        new TextFormField(
          decoration: InputDecoration(
              labelText: 'PASSWORD ',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green))),
          obscureText: true,
          validator: validatePassword,
          onSaved: (String val) {
            _password = val;
          },
        ),
        SizedBox(height: data.size.height / 90),
        new TextFormField(
          decoration: InputDecoration(
              labelText: 'DISPLAY NAME ',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green))),
          validator: validateUname,
          onSaved: (String val) {
            _displayName = val;
          },
        ),
        //Register button container
        SizedBox(height: data.size.height / 20.0),
        Container(
            height: data.size.height / 20.0,
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Colors.greenAccent,
              color: Colors.green,
              elevation: 7.0,
              child: new GestureDetector(
                onTap: () {
                  if (_key.currentState.validate()) {
                    print("form accepted");
                    onRegister();
                  } else {
                    setState(() {
                      _validate = true;
                    });
                  }
                },
                child: Center(
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            )),
        SizedBox(height: data.size.height / 30.0),
        //Return button container
        Container(
          height: data.size.height / 20.0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, style: BorderStyle.solid, width: 1.0),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20.0)),
            child: InkWell(
              onTap: () {
                //Return back to login page
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text('Go Back',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
              ),
            ),
          ),
        ),
      ],
    );
  } //End widget

  void onRegister() async {
    var api_instance = AuthApi();

    User user = new User();

    user.id = 1;
    user.username = _uname;
    user.password = _password;
    user.displayName = _displayName;

    try {
      print(user.toString());
      api_instance.register(user: user);
    } catch (e) {
      print("Exception $e");
    }
  } //End function

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Username is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  } //end validate Name

  String validateUname(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Username is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  } //end validate Name

  //https://stackoverflow.com/questions/56253787/how-to-handle-textfield-validation-in-password-in-flutter
  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter valid password.\nMust contain at least one upper case,\nOne lower case,\nOne digit and one special character';
      else
        return null;
    } //End if else
  } //End validate password function
} //end class
