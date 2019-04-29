import 'package:flutter/material.dart';
import 'package:speechlist/screens/create_room.dart';
import 'package:speechlist/screens/room.dart';
import 'package:speechlist/screens/search_room.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SearchRoomPage(title: 'HomePage'),
      routes: <String, WidgetBuilder>{
        CreateRoomPage.routeName: (BuildContext context) => CreateRoomPage(title: "Create Room"),
        RoomPage.routeName: (BuildContext context) => RoomPage(),
      },
    );
  }
}
