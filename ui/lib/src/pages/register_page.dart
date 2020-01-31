import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/blocs/login_bloc.dart';
import 'package:vertex_ui/src/services/api.dart';
import 'package:vertex_ui/src/widgets/icon_card.dart';
import '../utils/validator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Member Variables
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final formKey = GlobalKey<FormState>();
  bool _validate = false;

  //bool _isLoading = false;
  User user = User();

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      //setState(() => _isLoading = true);
      form.save();
      print(user.toString());
      onRegister(user);
    }
  } //End function

  @override
  Widget build(BuildContext context) {
    user.id = 1; //Default value
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
                  key: formKey,
                  autovalidate: _validate,
                  child: formUI(),
                ),
              ),
              SizedBox(height: data.size.height / 30.00),
              //Call IconCard Widget
              new IconCard()
            ]));
  } //end builder

  Widget formUI() {
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
            onSaved: (String val) => this.user.username = val),
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
          onSaved: (String val) => this.user.password = val,
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
            onSaved: (String val) => this.user.displayName = val),
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
                onTap: () => _submit(),
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
              onTap: () => Navigator.of(context).pop(),
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

  void onRegister(User user) async {
    var apiInstance = AuthApi();
    try {
      apiInstance.register(user: user);
    } catch (e) {
      print("Exception $e");
    }
  } //End function
} //end class
