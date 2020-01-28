import 'package:flutter/material.dart';
import 'package:salary_app/services/auth.dart';
import 'models/user.dart';
import 'package:provider/provider.dart';
import 'screens/wrapper.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return StreamProvider<User>.value(
        value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Roboto'),
        home: Wrapper(),
      ),
    );
  }
}
