import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';
import 'package:vertex_ui/src/blocs/registration_bloc.dart';
import 'package:vertex_ui/src/pages/register/register_screen_presenter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    implements RegisterScreenContract {
  //Member Variables
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  InlineObject user = InlineObject();
  RegisterScreenPresenter _presenter;

  _RegisterPageState() {
    _presenter = new RegisterScreenPresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      //setState(() => _isLoading = true);
      form.save();
      print(user.toString());
      _presenter.doRegister(user);
    }
  } //End function

  @override
  Widget build(BuildContext context) {
    //Data about the device the application is running on
    final data = MediaQuery.of(context);

    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
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
            ]));
  } //end builder

  Widget formUI() {
    //Data about the device the application is running on
    final data = MediaQuery.of(context);
    final bloc = RegistrationBloc(); // Bloc pattern

    return new Column(
      children: <Widget>[
        StreamBuilder<String>(
          stream: bloc.username,
          builder: (context, snapshot) => TextFormField(
            onSaved: (String val) => this.user.username = val,
            onChanged: bloc.usernameChanged,
            decoration: InputDecoration(
                labelText: 'USERNAME',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                errorText: snapshot.error),
          ),
        ),
        SizedBox(height: data.size.height / 90),
        StreamBuilder<String>(
          stream: bloc.password,
          builder: (context, snapshot) => TextFormField(
            obscureText: true,
            onSaved: (String val) => this.user.password = val,
            onChanged: bloc.passwordChanged,
            decoration: InputDecoration(
                labelText: 'PASSWORD ',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                errorText: snapshot.error),
          ),
        ),
        SizedBox(height: data.size.height / 90),
        //Register button container
        SizedBox(height: data.size.height / 20.0),
        Container(
            height: data.size.height / 20.0,
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Colors.greenAccent,
              color: Colors.green,
              elevation: 7.0,
              child: StreamBuilder<bool>(
                stream: bloc.submitCheck,
                builder: (context, snapshot) => RaisedButton(
                  color: Colors.green,
                  onPressed: snapshot.hasData ? () => _submit() : null,
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
  }

  // Information snack bar. This is displayed if any errors happen during login
  void _showSnackBar(String text, Color color) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: color));
  } //End function

  @override
  void onRegisterError(String errorTxt) {
    _showSnackBar(errorTxt, Colors.red);
  }

  @override
  void onRegisterSuccess(InlineObject user) {
    _showSnackBar("Account successfully registered", Colors.green);
    //TODO - nav to login page
  } //End widget
} //end class
