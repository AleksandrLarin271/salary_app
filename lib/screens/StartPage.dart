import 'package:flutter/material.dart';
import 'package:salary_app/screens/authenticate/sign_in.dart';

class StartPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    _StartPageState();
  }
}

class _StartPageState extends State<StartPage>{
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((__){
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>SignIn()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child:new Container(
          child: new Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children:<Widget>[
                new Container(
                  padding: const EdgeInsets.only(top:300,bottom:20.0 ),
                  child:new FlatButton(
                      child: Image.asset('assets/images/Group.png')
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top:200, bottom: 47.0),
                  child: Image.asset('assets/images/image.png'),
                ),


              ]
          ),
        ),
      ),
    );
  }
}
