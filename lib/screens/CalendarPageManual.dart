import 'package:flutter/material.dart';
import 'CalendarPagePerdiem.dart';
import 'CalendarPageHourly.dart';
import 'AddingPage.dart';
import 'CalculatorPageManual.dart';
import 'ResultPageManual.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarPageManual extends StatefulWidget{
  Map<DateTime,List<dynamic>> events_map;
  SharedPreferences prefs;

  CalendarPageManual();
  CalendarPageManual.events(this.events_map,this.prefs);
  CalendarPageManual.prefs(this.prefs);
  @override
  State createState()=>(events_map==null)?_CalendarPageManualState.prefs(prefs):_CalendarPageManualState.events(events_map,prefs);
}

class _CalendarPageManualState extends State<CalendarPageManual>
{
  SharedPreferences prefs;
  Map<DateTime,List<dynamic>> events_map=null;
  SharedPreferences prefs_calculator=null;
  _CalendarPageManualState.prefs(this.prefs_calculator);
  _CalendarPageManualState.events(this.events_map,this.prefs_calculator);
  _CalendarPageManualState();
  CalendarController _controller;
  Map<DateTime,List<dynamic>> _events;
  List<dynamic> _selectedEvents;


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    if(events_map!=null)
    {
      _events=events_map;
      print("hello");
    }else {

      print("null");
    }
    _selectedEvents = [];
    if(prefs_calculator!=null){
      print("!=null");
      prefs=prefs_calculator;
      setState(() {
        prefs.setString("events_manual", json.encode((encodeMap(_events))));
      });
    }else {
      initPrefs();

    }
    print(_events);

  }

  initPrefs() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime,List<dynamic>>.from(decodeMap(json.decode(prefs.getString("events_manual") ?? "{}")));

    });
  }

  Map<String,dynamic> encodeMap(Map<DateTime,dynamic> map) {
    Map<String,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }
  Map<DateTime,dynamic> decodeMap(Map<String,dynamic> map) {
    Map<DateTime,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }
  String convert(String work){
    work=work.split("{")[1];
    work=work.split("}")[0];
    List<String> arr=work.split(",");
    String result="";
    arr.forEach((String a)=>{
      if(a.contains("hours")){
        result+=a+" "
      }
      else if (a.contains("minute"))
        {
          result+=a+" "
        }
      else if(a.contains("daily_earnings"))
          {
            result+=a+" "
          }
        else if(a.contains("note"))
            {
              result+=a+" "
            }

    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    String letter = 'C';

    return Scaffold(

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: Device.width,
                  padding: const EdgeInsets.only(top: 30, left: 10),
                  child:Row(
                    children: <Widget>[
                      Image.asset('assets/images/Group.png',width: 18.58,height: 26.0,),

                      Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Puantör",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.normal
                            ),
                          )
                      ),

                      Container(
                          padding: const EdgeInsets.only(left:170),
                          child: Container( width: 60,
                              child: FlatButton(
                                child: Image.asset("assets/images/stats.png"),
                                onPressed:(){
                                  Navigator.of(context).push(new MaterialPageRoute(builder:
                                      (BuildContext context) => ResultPageManual()));
                                } ,
                              )
                          )
                      ),
                      Container(
                          width: 60,
                          child:  FlatButton(
                            child: Image.asset("assets/images/settings.png"),
                            onPressed:(){
                              showDialog(context: context,
                                  builder: (context)=>AlertDialog(
                                    content: DropdownButton<String>(
                                      value: letter,
                                      onChanged:
                                          (val) => setState((){letter=val;
                                      print(letter);
                                      if (letter == 'A') {
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(builder:
                                                (BuildContext context) =>
                                                CalendarPageHourly()));
                                      }
                                      else if(letter=='B')
                                      {
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(builder:
                                                (BuildContext context) =>
                                                CalendarPagePerdiem()));
                                      }
                                      else if(letter=='C')
                                      {
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(builder:
                                                (BuildContext context) =>
                                                CalendarPageManual()));
                                      }
                                      }
                                      )


                                      ,
                                      items: [

                                        DropdownMenuItem<String>(
                                          value: 'C',
                                          child: Text('manuel entry'),
                                        ),DropdownMenuItem<String>(
                                          value: 'A',
                                          child: Text('hoursly wages'),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'B',
                                          child: Text('per diem type'),
                                        ),
                                      ],
                                    ),
                                  )
                              );
                            } ,
                          )
                      )
                    ],
                  )
              ),
              TableCalendar(
                events: _events,
                initialCalendarFormat: CalendarFormat.month,
                calendarStyle: CalendarStyle(
                    todayColor: Colors.orange,
                    selectedColor: Theme.of(context).primaryColor,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white)),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
                ),
                onDaySelected: (date, events) {
                  print(_controller.selectedDay);
                  setState(() {
                    _selectedEvents = events;
                  });
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                builders: CalendarBuilders(
                  singleMarkerBuilder:  (context, date, events) {
                    print("!!!!!!!!!!!!");
                    print(events);
                    return Container(
                        width: 40,
                        height: 40,

                        child: Column(
                            children: <Widget>[
                              Container(
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.blueGrey
                                  ),
                                  child: Center(
                                      child: Text("7" ,
                                          style: TextStyle(fontSize: 10))
                                  )
                              ),
                              Container(
                                  width: 40,
                                  margin: const EdgeInsets.only(top :15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.deepOrangeAccent
                                  ),
                                  child: Center(
                                      child: Text(events.split("{")[1].split("}")[0]
                                          .split(",")[2].split(":")[1] + "\$",
                                          style: TextStyle(fontSize: 10))
                                  )
                              ),

                            ]

                        )
                    );
                  },
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                calendarController: _controller,
              ),
              ..._selectedEvents.map((event) => ListTile(
                  title: Container(
                    margin: const EdgeInsets.all(5),
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20.0, // has the effect of softening the shadow
                        spreadRadius: 5.0, // has the effect of extending the shadow
                        offset: Offset(
                          10.0, // horizontal, move right 10
                          10.0, // vertical, move down 10
                        ),
                      )
                      ],
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),
                    ),
                    child:Row(
                      children: <Widget>[
                        Container(
                            width: 160,
                            margin: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(event.toString()
                                    .split("{")[1]
                                    .split("}")[0]
                                    .split(",")[4]
                                    .split(":")[1].trim().split(" ")[0]
                                  //.split(" ")[0]
                                  ,
                                  style: TextStyle(
                                      fontSize: 16
                                  ),
                                ),
                                Text(event.toString()
                                    .split("{")[1]
                                    .split("}")[0]
                                    .split(",")[3]
                                    .split(":")[1],
                                  style: TextStyle(
                                      color: hexToColor("#8A9199"),
                                      fontSize: 14
                                  ),
                                )
                              ],
                            )
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 5,bottom: 5,left: 70),
                            child:Text("\$"+event.toString()
                                .split("{")[1]
                                .split("}")[0]
                                .split(",")[2]
                                .split(":")[1],
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            )
                        )
                      ],
                    ),
                  )
              )
              ),
            ],
          ),

        ),
        floatingActionButton: FloatingActionButton(

          child: Icon(Icons.add),
          onPressed: (){
            setState(() {
              prefs.setString("events_manual", json.encode((encodeMap(_events))));
            });
            print (prefs.getString("job"));
            print(prefs.getString("manual"));

            print("CalculatorPage");
            Navigator.of(context).push(new MaterialPageRoute(builder:
                (BuildContext context) => CalculatorPageManual(
                _controller.selectedDay,
                _events,
                prefs
            )
            )
            );
          },
        )
    );
  }
  void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      Navigator.of(context).push(new MaterialPageRoute(builder:
          (BuildContext context) => CalendarPageManual()));
      print('I First Item');
    } else if (choice == Constants.SecondItem) {
      print('I Second Item');
    } else if (choice == Constants.ThirdItem) {
      print('I Third Item');
    }
  }
}
class Constants{
  static const String FirstItem = 'First Item';
  static const String SecondItem = 'Second Item';
  static const String ThirdItem = 'Third Item';

  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
    ThirdItem,
  ];




}