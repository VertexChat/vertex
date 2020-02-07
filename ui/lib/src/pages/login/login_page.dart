import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vertex_ui/src/blocs/login_bloc.dart';
import 'package:vertex_ui/src/pages/register_page.dart';
import 'package:vertex_ui/src/services/api.dart';
import 'package:vertex_ui/src/widgets/icon_card.dart';

import 'login_screen_presenter.dart';

class LoginPage extends StatefulWidget {
  //Member Variables
  final String pageTitle;

  /// Home page of application.
  /// Fields in Widget subclass always marked final
  LoginPage({Key key, this.pageTitle}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginScreenContract {
  //Member Variables
  bool rememberMe = false;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  Login login = Login();
  bool _isLoading = false;
  LoginScreenPresenter _presenter;

  //Constructor
  _LoginPageState() {
    //TODO: Complete auth for login
    _presenter = new LoginScreenPresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      //setState(() => _isLoading = true);
      form.save();
      print(login.toString());
      _presenter.doLogin(login);
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
            //Main Container heading
            Container(
              height: data.size.height / 2.5,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 45.0, 0.0, 0.0),
                    //height: data.size.height / 1.5,
                    child: AutoSizeText('Welcome',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: AutoSizeText('To',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                    child: AutoSizeText('Vertex',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            //Input fields for email & password container
            Container(
              height: data.size.height / 2.3,
              padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
              child: new Form(
                key: formKey,
                autovalidate: _validate,
                child: formUi(),
              ),
            ),
            //"Connect with" with text container
            //SizedBox(height: data.size.height / 1.0),
            Container(
                //https://github.com/flutter/flutter/issues/10156
                padding: EdgeInsets.only(
                    top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'or connect with',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ],
                )),
            //Call IconCard Widget
            new IconCard()
          ],
        ));
  } //end widget builder

  Widget formUi() {
    //Data about the device the application is running on
    final data = MediaQuery.of(context);
    // Bloc pattern
    final bloc = LoginBloc();

    return new Column(
      children: <Widget>[
        StreamBuilder<String>(
          stream: bloc.username,
          builder: (context, snapshot) => TextFormField(
            onChanged: bloc.usernameChanged,
            onSaved: (String val) => this.login.userName = val,
            decoration: InputDecoration(
              labelText: 'USERNAME',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              errorText: snapshot.error,
            ),
          ),
        ),
        StreamBuilder<String>(
          stream: bloc.password,
          builder: (context, snapshot) => TextFormField(
            obscureText: true,
            onChanged: bloc.passwordChanged,
            onSaved: (String val) => this.login.password = val,
            decoration: InputDecoration(
              labelText: 'PASSWORD',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              errorText: snapshot.error,
            ),
          ),
        ),
        //Forgot Password container
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(top: 10.0, left: 0.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        decoration: TextDecoration.underline),
                  ),
                ),
                //Remember Me checkbox
                //https://stackoverflow.com/questions/45986093/textfield-inside-of-row-causes-layout-exception-unable-to-calculate-size?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
                //https://stackoverflow.com/questions/53842697/how-do-you-add-a-label-title-text-to-a-checkbox-in-flutter
                Flexible(
                  //TODO: Needs some work
                  child: CheckboxListTile(
                    title: Text("Remember me"),
                    value: rememberMe,
                    onChanged: (bool value) {
                      //TODO:
                      setState(() => rememberMe = value);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ]),
        ),
        SizedBox(height: data.size.height / 80),
        //Login container
        Container(
          height: data.size.height / 20.0,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.greenAccent,
            color: Colors.green,
            elevation: 5.0,
            child: StreamBuilder<bool>(
              stream: bloc.submitCheck,
              builder: (context, snapshot) => RaisedButton(
                color: Colors.green,
                onPressed: snapshot.hasData ? () => _submit() : null,
                child: Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: data.size.height / 40.0),
        //Main register container
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
                //Navigate ot register page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Center(
                child: Text('Register',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
              ),
            ),
          ),
        ),
      ],
    );
  } //End builder

  // information snack bar. This is displayed if any errors happen during login
  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
    // setState(() => _isLoading = false);
  } //End function

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
  }

  @override
  void onLoginSuccess(Login login) {
    _showSnackBar(login.toString());
    // setState(() => _isLoading = false);
    // TODO: implement onLoginSuccess
  } //End onLogin function
} //end class
