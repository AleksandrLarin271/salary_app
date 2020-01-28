import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:salary_app/screens/AddingPage.dart';
import 'CalendarPageHourly.dart';
import 'Work.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'dart:convert';
import 'CalendarPagePerdiem.dart';

class CalculatorPagePerdiem extends StatefulWidget{
  final DateTime selected_day;
  final Map<DateTime,List<dynamic>> events_map;
  SharedPreferences prefs;
  CalculatorPagePerdiem(this.selected_day,this.events_map,this.prefs);
  @override
  State createState()=>_CalculatorPagePerdiemState(
      this.selected_day,
      this.events_map,
      this.prefs);
}

class _CalculatorPagePerdiemState extends State<CalculatorPagePerdiem>
{



  final file = new File('events.json');
  final DateTime selected_day;
  final SharedPreferences prefs;
  final Map<DateTime,List<dynamic>> events_map;
  _CalculatorPagePerdiemState(this.selected_day,this.events_map,this.prefs);
  TextEditingController  _controller_earning;
  TextEditingController _controller_message;
  TextEditingController _controller_hours;
  TextEditingController _controller_minute;

  var hours;
  var minute;
  var date;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _controller_earning = TextEditingController();
    _controller_message=TextEditingController();
    _controller_hours=TextEditingController();
    _controller_minute=TextEditingController();
    date=new DateTime.now();
  }


  @override
  Widget build(BuildContext context) {
    var perdiem=0.0;
    return Scaffold(
        body:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[

                    FlatButton(
                      padding: EdgeInsets.only(top:50.0, left: 10),
                      onPressed: (){
                        Navigator.of(context).push(new MaterialPageRoute(builder:
                            (BuildContext context) => CalendarPageHourly()));
                      },
                      child: Image.asset('assets/images/arrow_back.png'),
                    ),


                  ],
                ),
                new Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 15,left: 37),
                      child: Text(
                          "Add Work",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              letterSpacing:  0.66,
                              color: hexToColor("#25265E")
                          )
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 25,left: 37),
                      child: Text(
                          "Working Hours",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              letterSpacing:  0.66,
                              color: hexToColor("#787993")
                          )
                      ),
                    ),
                  ],
                ),

                new Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 5,left: 37),
                      child: Text(
                          "Today, 08:00 — 09:00 AM",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              letterSpacing:  0.66,
                              color: hexToColor("#25265E")
                          )
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 20,left: 37),
                      child: Text(
                          "per diem",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              letterSpacing:  0.66,
                              color: hexToColor("#787993")
                          )
                      ),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 32,
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      decoration:new BoxDecoration(
                        borderRadius: BorderRadius
                            .all(Radius.circular(5)
                        ),
                        color: Colors.blue,
                      ),child: FlatButton(
                      child:Text("0.5",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              letterSpacing:  0.66,
                              color: hexToColor("#FFFFFF")
                          )
                      ),
                      onPressed: (){
                        perdiem=0.5;
                        _controller_earning.text=(int.tryParse(prefs.getString("perdiem"))).toString().split(".")[0];

                      },
                    ),
                    ),
                    Container(
                      width: 60,
                      height: 32,

                      margin: const EdgeInsets.only(top: 10, left: 10),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius
                            .all(Radius.circular(5)
                        )
                        ,
                        color: Colors.blue,
                      ),
                      child: FlatButton(
                        child:Text("1.0",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                letterSpacing:  0.66,
                                color: hexToColor("#FFFFFF")
                            )
                        ),
                        onPressed: (){
                          perdiem=1.0;
                          _controller_earning.text=(int.tryParse(prefs.getString("perdiem"))*2).toString().split(".")[0];

                        },
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 32,

                      margin: const EdgeInsets.only(top: 10, left: 10),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius
                            .all(Radius.circular(5)
                        )
                        ,
                        color: Colors.blue,
                      ),child: FlatButton(
                      child:Text("1.5",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              letterSpacing:  0.66,
                              color: hexToColor("#FFFFFF")
                          )
                      ),
                      onPressed: (){
                        perdiem=1.5;
                        _controller_earning.text=(int.tryParse(prefs.getString("perdiem"))*2.5).toString().split(".")[0];

                      },
                    ),
                    ),
                    Container(
                      width: 60,
                      height: 32,

                      margin: const EdgeInsets.only(top: 10, left: 10),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius
                            .all(Radius.circular(5)
                        )
                        ,
                        color: Colors.blue,
                      ),child: FlatButton(
                      child:Text("2.0",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              letterSpacing:  0.66,
                              color: hexToColor("#FFFFFF")
                          )
                      ),
                      onPressed: (){
                        perdiem=2.0;
                        _controller_earning.text=(int.tryParse(prefs.getString("perdiem"))*3.0).toString().split(".")[0];

                      },
                    ),
                    ),
                    Container(
                      width: 60,
                      height: 32,

                      margin: const EdgeInsets.only(top: 10, left: 10),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius
                            .all(Radius.circular(5)
                        )
                        ,
                        color: Colors.blue,
                      ) ,child: FlatButton(
                      child:Text("2.5",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              letterSpacing:  0.66,
                              color: hexToColor("#FFFFFF")
                          )
                      ),
                      onPressed: (){
                        perdiem=2.5;
                        _controller_earning.text=(int.tryParse(prefs.getString("perdiem"))*3.5).toString().split(".")[0];
                      },
                    ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                          "Daily earnings",
                          style:TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.66,
                              color: hexToColor("#787993")
                          )
                      ),
                      padding: const EdgeInsets.only(left: 37,top:20),
                    )
                  ],
                ),
                new Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 37,right: 20),
                      width:200,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _controller_earning,
                        enabled: false,
                        style: TextStyle(fontSize: 16),
                        decoration: new InputDecoration(
                            hintText: "100\$",
                            hintStyle: TextStyle(color: hexToColor("#DFDFE4"))
                        ),
                      ),
                    ),
                    Container(child: Center(child: Text("\$"),),)
                  ],
                ),
                new Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                          "Note:",
                          style:TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0.66,
                              color: hexToColor("#787993")
                          )
                      ),
                      padding: const EdgeInsets.only(left: 37,top:20),
                    )
                  ],
                ),
                new Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 37,right: 20),
                      width:Device.screenWidth-50,
                      child: TextField(
                        controller: _controller_message,
                        style: TextStyle(fontSize: 16),
                        decoration: new InputDecoration(
                            hintText: "Message...",
                            hintStyle: TextStyle(color: hexToColor("#DFDFE4"))
                        ),
                      ),
                    )
                  ],
                ),


                new Row(
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(top :100, left : 37 ),
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
                            Work work=new Work("","", _controller_earning.text, _controller_message.text,selected_day,perdiem.toString());
                            events_map[selected_day]=[work.toString()];
                            prefs.setString("events_perdiem", json.encode((encodeMap(events_map))));
                            print(prefs.getString("job"));
                            Navigator.of(context).
                            push(
                                new MaterialPageRoute(
                                    builder:
                                        (BuildContext context) =>
                                        CalendarPagePerdiem.events(events_map,prefs)
                                )
                            );

                            print(work.toString());
                          },
                        ),
                      ),
                    ]
                )
              ],
            )
        )
    );
  }
  Map<String,dynamic> encodeMap(Map<DateTime,dynamic> map) {
    Map<String,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }
}