import 'dart:io' show Platform;

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:speechlist/screens/create_room.dart';
import 'package:speechlist/screens/create_room2.dart';
import 'package:speechlist/screens/create_room3.dart';
import 'package:speechlist/screens/room.dart';
import 'package:speechlist/screens/search_room.dart';

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

void main() {
  _setTargetPlatformForDesktop();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const PrimaryColor = const Color(0xFF00206B);
  static final primaryColorLight = PrimaryColor.withOpacity(0.7);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
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
        CreateRoomPage.routeName: (BuildContext context) => CreateRoomPage(room: ModalRoute.of(context).settings.arguments),
        RoomPage.routeName: (BuildContext context) => RoomPage(ModalRoute.of(context).settings.arguments),
        CreateRoomPage2.routeName: (BuildContext context) => CreateRoomPage2(room: ModalRoute.of(context).settings.arguments),
        CreateRoomPage3.routeName: (BuildContext context) => CreateRoomPage3(room: ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
