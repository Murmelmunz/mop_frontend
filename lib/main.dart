import 'package:flutter/material.dart';
import 'package:speechlist/screens/create_room.dart';
import 'package:speechlist/screens/room.dart';
import 'package:speechlist/screens/search_room.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const PrimaryColor = const Color(0xFF00206B);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: SearchRoomPage(title: 'HomePage'),
      routes: <String, WidgetBuilder>{
        SearchRoomPage.routeName: (BuildContext context) => SearchRoomPage(title: 'Homepage'),
        CreateRoomPage.routeName: (BuildContext context) => CreateRoomPage(title: "Create Room"),
        RoomPage.routeName: (BuildContext context) => RoomPage(ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
