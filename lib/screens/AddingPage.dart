import 'package:flutter/material.dart';
import 'package:salary_app/screens/CalendarPageHourly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddingPage extends StatefulWidget {
  SharedPreferences prefs;
  @override
  State createState()=>_AddingPageState(prefs);
}


class _AddingPageState extends State<AddingPage>{
  SharedPreferences prefs;
  _AddingPageState(prefs);
  TextEditingController  _controller_job;
  TextEditingController  _controller_perdiem;
  TextEditingController  _controller_hourly;
  TextEditingController  _controller_manual;


  @override
  void initState() {
    initPrefs();
    _controller_job = TextEditingController();
    _controller_perdiem=TextEditingController();
    _controller_hourly=TextEditingController();
    _controller_manual=TextEditingController();
  }
  initPrefs() async{
    prefs = await SharedPreferences.getInstance();
    print(prefs.getString("events"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
            child: new Column(

                children:<Widget>[

                  new Row(
                      children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.only(top: 93,left:20),
                          child:new Text("Add Job",style: TextStyle(fontSize: 24, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal,letterSpacing: 0.66667)),
                        ),
                      ]),
                  new Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top:20 ,left:20),
                          child:new Text("First, add a business to indicate "+
                              "your boiler type.",
                            style: TextStyle(fontSize: 16),),)
                      ]),
                  new Container(

                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child:new TextField(
                        controller: _controller_job,
                        style: TextStyle(fontSize: 16),
                        decoration: new InputDecoration(
                            hintText: "Job Name"
                        ),

                      )
                  ),
                  new Row(
                      children: <Widget>[
                        Container(
                          child:new Text("Select Earnings Type",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14)),
                          padding: const EdgeInsets.only(left: 20, top : 10),

                        ),

                      ]
                  ),
                  new Row(
                      children: <Widget>[
                        new Container(
                          width: 200,
                          padding: const EdgeInsets.only(top :30, left : 20, right: 20 ),
                          child: FlatButton(
                            color:hexToColor("#E9F9F0"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23)
                            ),
                            child: Container(
                                child:Row(children: <Widget>[
                                  Container(
                                    width: 45,
                                    padding: const EdgeInsets.only(right: 15),
                                    child:Image.asset('assets/images/Bitmap.png'),
                                  ),
                                  Text('per diem',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                          color: hexToColor("#2DC76D"))),
                                ]
                                )
                            ),
                            onPressed: (){},
                          ),
                        ),
                        Container (
                            padding: const EdgeInsets.only(right: 20),
                            width: 150.0,
                            child: TextField(
                              controller: _controller_perdiem,
                              keyboardType: TextInputType.number,

                              decoration: const InputDecoration(hintText: "50 \$"),

                            )),

                      ]
                  ),//green
                  new Row(
                      children: <Widget>[
                        new Container(
                          width: 200,
                          padding: const EdgeInsets.only(top :30, left : 20,right: 20 ),
                          child: FlatButton(

                            color: hexToColor("#ffe2dc"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23)
                            ),
                            child: Container(
                                child:Row(children: <Widget>[
                                  Container(
                                    width: 45,
                                    padding: const EdgeInsets.only(right: 15),
                                    child:Image.asset('assets/images/Bitmap2.png'),
                                  ), Text('hourly wages',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: hexToColor("#FF7052"))),
                                ]
                                )
                            ),
                            onPressed: (){},
                          ),
                        ),

                        Container (
                            padding: const EdgeInsets.only(right: 20),
                            width: 150.0,
                            child: TextField(
                              keyboardType: TextInputType.number,

                              controller: _controller_hourly,
                              decoration: const InputDecoration(hintText: "5 \$"),

                            )),

                      ]
                  ),// orange
                  new Row(
                      children: <Widget>[
                        new Container(
                          width: 200,
                          padding: const EdgeInsets.only(top :30, left : 20,right: 20),

                          child: FlatButton(
                            color:hexToColor("#e3d9fc"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23)
                            ),

                            child: Container(
                                child:Row(children: <Widget>[
                                  Container(
                                    width: 45,
                                    padding: const EdgeInsets.only( left:0,right: 15),
                                    child:Image.asset('assets/images/Bitmap3.png'),
                                  ),
                                  Text('manual entry',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: hexToColor("#7540EE"))),


                                ],)
                            ),
                            onPressed: (){},
                          ),
                        ),
                        Container (
                            padding: const EdgeInsets.only(right: 20),
                            width: 150.0,
                            child: TextField(
                              controller: _controller_manual,
                              keyboardType: TextInputType.number,

                              decoration: const InputDecoration(hintText: "0"),

                            )),

                      ]
                  ),// purpule
                  new Row(
                      children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.only(top :30, left : 20 ),
                          child: FlatButton(
                            color:hexToColor("#ffd4cb"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23)
                            ),
                            child: Text('Saved',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20.0,
                                    color: hexToColor("#FF7052"))),
                            onPressed: (){
                              setState(() {
                                print("312");
                                prefs.setString("job", json.encode(
                                    _controller_job.text));
                                prefs.setString("perdiem",
                                    _controller_perdiem.text);
                                prefs.setString("hourly",
                                    _controller_hourly.text);
                                prefs.setString("manual",
                                    _controller_manual.text);
                              });
                              Navigator.of(context).push(new MaterialPageRoute(builder:
                                  (BuildContext context) => CalendarPageHourly()));
                            },
                          ),
                        ),
                      ]
                  )
                ]

            )

        )
    );
  }

}
Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}