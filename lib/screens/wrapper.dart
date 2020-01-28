import 'package:salary_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:salary_app/screens/authenticate/authenticate.dart';
import 'CalendarPageHourly.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return CalendarPageHourly();
    }

  }
}