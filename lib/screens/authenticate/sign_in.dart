import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salary_app/screens/authenticate/register.dart';
import 'package:salary_app/services/auth.dart';
import 'package:salary_app/screens/StartPage.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Image.asset('assets/images/Group.png'),
                  ),
                  new Container(
                    padding: EdgeInsets.only(top: 60.0, left: 15),
                    child: Text('Puantör', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(top: 24),
                    child: Text('Welcome to salary calculation app! \nPlease login.', style: TextStyle(fontSize: 20.0),),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Enter E-mail'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Enter Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(top: 30),
                    child: RaisedButton(
                     shape: RoundedRectangleBorder(
                       side: BorderSide(color: Color.fromRGBO(117, 64, 238, 1),width: 2),
                       borderRadius: BorderRadius.circular(23.0),
                     ),
                      color: Color.fromRGBO(117, 64, 238, 0.2),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Color.fromRGBO(117, 64, 238, 1), fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if(result == null) {
                            setState(() {
                              error = 'Could not sign in with those credentials';
                            });
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(top: 180.0, left: 30.0),
                    child: Text('Still no account?', style: TextStyle(fontSize: 20.0),),
                  ),
                  new Container(
                    child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Register()));
                      },
                      padding: EdgeInsets.only(top: 180.0),
                      child: Text('Create one!', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}