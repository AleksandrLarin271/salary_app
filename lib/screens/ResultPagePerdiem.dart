import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'AddingPage.dart';
import 'CalendarPagePerdiem.dart';

class ResultPagePerdiem extends StatefulWidget {
  SharedPreferences prefs;
  ResultPagePerdiem.prefs(this.prefs);
  ResultPagePerdiem();
  @override
  State createState()=>_ResultPagePerdiemState();
}

class _ResultPagePerdiemState extends State<ResultPagePerdiem> {

  SharedPreferences prefs;
  Map<DateTime,List<dynamic>> _events;
  _ResultPagePerdiemState.prefs(this.prefs);
  _ResultPagePerdiemState();

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
      _events = Map<DateTime,List<dynamic>>.from(decodeMap(json.decode(prefs.getString("events_perdiem") ?? "{}")));
    });
    print(prefs.getString("events_perdiem"));
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
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(5),
                        bottomLeft:Radius.circular(5)

                    )
                ),
                child:Center(
                  child:Text(
                      value.toString()
                          .split("{")[1]
                          .split("}")[0]
                          .split(",")[5]
                          .split(":")[1],
                      style:TextStyle(
                        fontSize: 36,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      )
                  ),
                )
            ),
            Container(
                width: 240,
                margin: const EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
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
            Text("\$"+value.toString()
                .split("{")[1]
                .split("}")[0]
                .split(",")[2]
                .split(":")[1],
              style: TextStyle(
                  fontSize: 16
              ),
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
    var res=0.0;
    _events.forEach((var key,var value) {
      print(double.tryParse(value.toString()
          .split("{")[1]
          .split("}")[0]
          .split(",")[5]
          .split(":")[1]));
      res+=(double.tryParse(value.toString()
          .split("{")[1]
          .split("}")[0]
          .split(",")[5]
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
                                    builder:(BuildContext context) =>CalendarPagePerdiem()
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
                            Column(
                              children: <Widget>[
                                Text(
                                    "totel per diem",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color:hexToColor("#6B7897")
                                    )
                                ),
                                Container(
                                    margin: const EdgeInsets.all(5),
                                    child:Text(
                                        getAllHours(),
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                            color:hexToColor("#FF7052")
                                        )
                                    )),
                                Text(
                                    "son ay",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.normal,
                                        color:hexToColor("#34485E")
                                    )
                                )
                              ],
                            ),
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
                (BuildContext context) => CalendarPagePerdiem()

            )
            );
          },
        )
    );

  }


}