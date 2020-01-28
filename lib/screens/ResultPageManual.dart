import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'AddingPage.dart';
import 'CalendarPageManual.dart';

class ResultPageManual extends StatefulWidget {
  SharedPreferences prefs;
  ResultPageManual.prefs(this.prefs);
  ResultPageManual();
  @override
  State createState()=>_ResultPageManualState();
}

class _ResultPageManualState extends State<ResultPageManual> {

  SharedPreferences prefs;
  Map<DateTime,List<dynamic>> _events;
  _ResultPageManualState.prefs(this.prefs);
  _ResultPageManualState();

  @override
  void initState() {
    initPrefs();
    setState(() {

    });
    print(_events.toString());

  }

  initPrefs() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime,List<dynamic>>.from(decodeMap(json.decode(prefs.getString("events_manual") ?? "{}")));
    });
    print(prefs.getString("events_manual"));
    print(prefs.getString("job"));

  }

  Map<DateTime,dynamic> decodeMap(Map<String,dynamic> map) {
    Map<DateTime,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  List<Widget> er(){
    List<Container> list_res=new List<Container>();
    _events.forEach((var key,var value){
      list_res.add(Container(
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
                width: 200,
                margin: const EdgeInsets.only(top: 5,bottom: 5,right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(value.toString()
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
                    Text(value.toString()
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
                child:Text("\$"+value.toString()
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

      );
      print('${key}  ${value.toString()} ');
    });
    return list_res;

  }

  String getAllHours(){
    int res=0;
    _events.forEach((var key,var value) {
      print(int.tryParse(value.toString()
          .split("{")[1]
          .split("}")[0]
          .split(",")[0]
          .split(":")[1]));
      res+=(int.tryParse(value.toString()
          .split("{")[1]
          .split("}")[0]
          .split(",")[0]
          .split(":")[1]));
    });

    return res.toString();
  }

  String getAllMoney(){
    int res=0;
    _events.forEach((var key,var value) {
      res+=(int.tryParse(value.toString()
          .split("{")[1]
          .split("}")[0]
          .split(",")[2]
          .split(":")[1]));
    });
    return res.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(top:20),
                            child:FlatButton(
                              child: Image.asset("assets/images/arrow_back.png"),
                              onPressed: (){
                                Navigator.of(context).
                                push(new MaterialPageRoute(
                                    builder:(BuildContext context) =>CalendarPageManual()
                                )
                                );
                              },
                            )
                        ),
                        Center(
                            child:Container(
                                margin: const EdgeInsets.only(top:15),
                                child:Text("Earnings",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal)
                                )
                            )
                        )
                      ]
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(5)
                      ),

                    ),
                    margin: const EdgeInsets.only(top:10,bottom: 20,left: 10,right: 10),
                    height: 100,
                    child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                height: 300,
                                child:Center(
                                    child:
                                    Column(
                                      children: <Widget>[
                                        Text(
                                            "total earnings",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                color:hexToColor("#6B7897")
                                            )
                                        ),
                                        Text(
                                            "\$"+getAllMoney(),
                                            style: TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FontStyle.normal,
                                                color:hexToColor("#1F3F66")
                                            )
                                        ),
                                        Text(
                                            "(United States Dollar - USD)",
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FontStyle.normal,
                                                color:hexToColor("#1F3F66")
                                            )
                                        )
                                      ],
                                    )
                                )
                            )
                          ],

                        )
                    ),

                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: er()

                  )
                ]
            )
        ),
        floatingActionButton: FloatingActionButton(

          child: Icon(Icons.add),
          onPressed: (){
            print("CalculatorPage");
            Navigator.of(context).push(new MaterialPageRoute(builder:
                (BuildContext context) => CalendarPageManual()

            )
            );
          },
        )
    );

  }


}