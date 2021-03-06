import 'dart:io' show Platform;

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:speechlist/screens/contribution_dialog.dart';
import 'package:speechlist/screens/create_room.dart';
import 'package:speechlist/screens/create_room2.dart';
import 'package:speechlist/screens/create_room3.dart';
import 'package:speechlist/screens/join_dialog.dart';
import 'package:speechlist/screens/room.dart';
import 'package:speechlist/screens/search_room.dart';
import 'package:speechlist/screens/evaluate_room.dart';

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
//          subhead: TextStyle(color: PrimaryColor, fontSize: 20), // for dropdown and textfield
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))
          ),
        ),

        buttonTheme: ButtonThemeData(
          alignedDropdown: true,
          buttonColor: PrimaryColor,
          textTheme: ButtonTextTheme.primary
        ),

      ),
      home: SearchRoomPage(title: 'HomePage'),
      routes: <String, WidgetBuilder>{
        SearchRoomPage.routeName: (BuildContext context) => SearchRoomPage(title: 'Homepage'),
        JoinDialogPage.routeName: (BuildContext context) => JoinDialogPage(room: ModalRoute.of(context).settings.arguments),
        ContributionPage.routeName: (BuildContext context) => ContributionPage(ModalRoute.of(context).settings.arguments),
        CreateRoomPage.routeName: (BuildContext context) => CreateRoomPage(room: ModalRoute.of(context).settings.arguments),
        RoomPage.routeName: (BuildContext context) => RoomPage(ModalRoute.of(context).settings.arguments),
        CreateRoomPage2.routeName: (BuildContext context) => CreateRoomPage2(room: ModalRoute.of(context).settings.arguments),
        CreateRoomPage3.routeName: (BuildContext context) => CreateRoomPage3(room: ModalRoute.of(context).settings.arguments),
        EvaluateRoomPage.routeName: (BuildContext context) => EvaluateRoomPage(room: ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
