// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBackgroundService.initialize(onStart);
  runApp(const MyApp());
}

// app default state : 
String changer = 'game_changer';

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  // Run taks here :
  print(changer);
  service.onDataReceived.listen((event) {
    // !IMPORTANT 
    // must include print statement to pass null check:
    // other wise you get error: 
    print(event!);

    // use Contain key or contain value:
    // for ignore null errors :  
    if (event.containsKey('action')) {
      changer = 'game';
      return;
    }

    service.setNotificationInfo(
      title: "gamer",
      content: "Updated at ${DateTime.now()}",
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.teal[900],
      ),
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.black87,
              title:
                  Text('feelsafe noty', style: TextStyle(color: Colors.white))),
            body: Center(child:
            ElevatedButton(
            child:Text('Chnage val'), onPressed: (){

              FlutterBackgroundService().sendData({
              "action": "action",
            });

            },) 
             ),
       )

    );
  }
}
