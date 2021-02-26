import 'dart:ui';
import "dart:async";
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

void main()=>runApp(waterr());

class waterr extends StatefulWidget {
  @override
  myapp createState()=>myapp();//{return myapp()};
}
class myapp extends State<waterr>{
  var timer=0,cancel=1;
  var selectedParam="Hours";
  FlutterLocalNotificationsPlugin flt_noti;
  @override
  void initState()
  {
    super.initState();
    var androidInitialize=new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOSInitialize= new IOSInitializationSettings();
    var Initialization= new InitializationSettings(androidInitialize, IOSInitialize);
    flt_noti=new FlutterLocalNotificationsPlugin();
    flt_noti.initialize(Initialization,onSelectNotification: notificationselected);
  }
  Future<void> shownotification() async {
    var androidNot = new AndroidNotificationDetails(
        "1", "Waterr", "Water Remainder", importance: Importance.Max,icon: '@drawable/ic_launcher');
    var IOSNot = new IOSNotificationDetails();
    var generalNot = new NotificationDetails(androidNot, IOSNot);
    if (selectedParam == "Hours") {
      //scheduledT=DateTime.now().add(Duration(hours: timer));
      Timer.periodic(Duration(hours: timer),(timer) async{
        if(cancel==0){
          timer.cancel();
        }
        await flt_noti.show(0, "waterr", "Drink water", generalNot);
      });
      print("\n\nhours\n\n");
    }
    else if (selectedParam == "Minutes") {
      //scheduledT = DateTime.now().add(Duration(minutes: timer));
      Timer.periodic(Duration(minutes: timer),(timer) async{
        if(cancel==0){
          timer.cancel();
        }
        await flt_noti.show(0, "waterr", "Drink water", generalNot);
      });
      print("\n\nminutes\n\n");
    }
    else {
      //scheduledT = DateTime.now().add(Duration(seconds: timer));
      Timer.periodic(Duration(seconds: timer),(timer) async{
        if(cancel==0){
          timer.cancel();
        }
        await flt_noti.show(0, "waterr", "Drink water", generalNot);
      });
      print("\n\nseconds\n\n");
    }
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : SafeArea
        (
        child:Scaffold
          (
               appBar: AppBar(title: Text("Water remainder"),backgroundColor: Colors.blue),
               body: Center
                 (
                     child: Container
                       (
                         height:400,
                       alignment: Alignment.topCenter,
                       child: new Column
                         (
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           new Text("$selectedParam:$timer",
                           style: new TextStyle(fontSize: 40.0),
                           ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                            new DropdownButton
                              (
                                value: selectedParam,
                              items:[
                                DropdownMenuItem(
                                  child: new Text("Seconds"),
                                  value:"Seconds",
                                ),
                                DropdownMenuItem(
                                  child: new Text("Minutes"),
                                  value:"Minutes",
                                ),
                                DropdownMenuItem(
                                 child: new Text("Hours"),
                                 value:"Hours",
                                ),
                                ],
                              onChanged: (val)
                              {
                               setState(() {
                                 selectedParam=val;
                               });
                              },
                              ),
                            new FloatingActionButton
                              (
                              child: Icon(Icons.add),
                              onPressed: () {
                                 setState(() {
                                      timer++;
                                  });  },

                              ),
                             new FloatingActionButton
                               (
                                child: Icon(Icons.remove),
                                  onPressed: ()
                                  {
                                    setState(() {
                                      if(timer>0)
                                        timer--;
                                        });
                                  },
                                )]
                            ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                new RaisedButton
                                  (
                                    onPressed:()
                                    {
                                      cancel=1;
                                      shownotification();
                                    },
                                    child:new Text("Set Remainder")),
                                  new RaisedButton
                                    (
                                      onPressed:()
                                      {
                                        setState(() {
                                          cancel=0;
                                        });
                                      },
                                      child:new Text("Cancel remainder"))
                             ])
                            ]
                            )
                      )
                    )
                   ),
                  ),
                );
      }

  Future<void> notificationselected(String Payload) async{
    showDialog(context: context,
        builder: (context)=>AlertDialog(
            content: Text("Drink water")
        )
    );
  }
    }