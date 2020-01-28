import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salary_app/screens/CalendarPageManual.dart';
import 'package:salary_app/screens/Work.dart';
import 'package:salary_app/screens/AddingPage.dart';
import 'dart:convert';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:salary_app/screens/CalendarPageHourly.dart';

class CalculatorPageManual extends StatefulWidget{
  final DateTime selected_day;
  final Map<DateTime,List<dynamic>> events_map;
  SharedPreferences prefs;
  CalculatorPageManual(this.selected_day,this.events_map,this.prefs);
  @override
  State createState()=>_CalculatorPageManualState(
      this.selected_day,
      this.events_map,
      this.prefs);
}

class _CalculatorPageManualState extends State<CalculatorPageManual>
{

  final DateTime selected_day;
  final SharedPreferences prefs;
  final Map<DateTime,List<dynamic>> events_map;
  _CalculatorPageManualState(this.selected_day,this.events_map,this.prefs);
  TextEditingController  _controller_earning;
  TextEditingController _controller_message;


  var hours;
  var minute;
  var date;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _controller_earning = TextEditingController();
    _controller_message=TextEditingController();
    date=new DateTime.now();
    _controller_earning.text=(int.parse(prefs.getString("manual"))*7).toString();
  }


  @override
  Widget build(BuildContext context) {
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
                        style: TextStyle(fontSize: 16),
                        enabled: false,
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
                            Work work=new Work("","", _controller_earning.text, _controller_message.text,selected_day,"");
                            events_map[selected_day]=[work.toString()];
                            prefs.setString("events_manual", json.encode((encodeMap(events_map))));
                            print(prefs.getString("job"));
                            Navigator.of(context).
                            push(
                                new MaterialPageRoute(
                                    builder:
                                        (BuildContext context) =>
                                        CalendarPageManual.events(events_map,prefs)
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