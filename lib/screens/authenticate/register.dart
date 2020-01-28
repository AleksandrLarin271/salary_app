import 'package:flutter/material.dart';
import 'package:salary_app/screens/AddingPage.dart';
import 'package:salary_app/screens/authenticate/sign_in.dart';
import 'package:salary_app/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    child: FlatButton(
                      child: Image.asset('assets/images/left-arrow.png'),
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>SignIn()));
                      },
                    ),
                  )
                ],
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.only(left: 32.0, top: 20.0),
                    child: Text('Sign Up', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 30.0, ),),
                  )
                ],
              ),
              new Row(
                children: <Widget>[
                  new Container(
                      padding: EdgeInsets.only(left: 32.0, top: 10),
                      child: Text('Create an account to use Puantör\nwithout limits.\nFor free.', style: TextStyle(fontFamily: 'Robotico', fontSize: 22.0, color: Color.fromRGBO(120, 121, 147, 1)))
                  )
                ],
              ),
              new Container(
                padding: EdgeInsets.only(top: 32),
                width: 320,
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Your email here'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 12),
                width: 320,
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Your password here'),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 30),
                child:RaisedButton(
                    color: Color.fromRGBO(250, 176, 80, 0.2),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Color.fromRGBO(255, 112, 82, 1),width: 1),
                      borderRadius: BorderRadius.circular(23.0),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Color.fromRGBO(255, 112, 82, 1), fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        if(result == null) {
                          setState(() {
                            error = 'Please supply a valid email';

                            Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>AddingPage()));
                          });
                        }
                      }
                    }
                ),
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(top: 160, left:48),
                    child: Text('I already have an account!', style: TextStyle(fontSize: 22.0),)
                  ),
                  new Container(
                      margin: EdgeInsets.only(top: 160, right: 9),
                    child: FlatButton(
                      child: Text('Login',style: TextStyle(fontSize: 22.0, decoration: TextDecoration.underline, color: Colors.deepOrangeAccent)),
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>SignIn()));
                      },
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}