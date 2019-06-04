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
        accentColor: PrimaryColor,
        cursorColor: PrimaryColor,

        textTheme: TextTheme(
          body1: TextStyle(color: PrimaryColor),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))
          ),
        ),

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
