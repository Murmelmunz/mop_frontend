import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:speechlist/main.dart';
import 'package:speechlist/models/room.dart';
import 'package:http/http.dart' as http;

class RoomPage extends StatefulWidget {
  static const String routeName = "/room";
  int roomId;

  RoomPage(int roomId) {
    this.roomId = roomId;
  }

  @override
  _RoomPageState createState() => _RoomPageState(this.roomId);
}

class _RoomPageState extends State<RoomPage> {
  int roomId;
  Future<Room> room;

  _RoomPageState(int roomId) {
    this.roomId = roomId;
  }

  void initState() {
    super.initState();
    this.room = createRoom();
  }

  Future<Room> createRoom() async {
    final response = await http.get(
        Uri.encodeFull('http://10.0.2.2:3000/room/$roomId'),
        headers: {"Content-Type": "application/json"})
      .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("success: " + response.body);
      return Room.fromJSON(json.decode(response.body));
    } else {
      throw('error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final num args = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Room Page $args"),
        backgroundColor: MyApp.PrimaryColor,
      ),

      body: FutureBuilder<Room>(
        future: room,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(snapshot.data.topic),
                Text(snapshot.data.meetingPoint),
                Text("${snapshot.data.roomId}"),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),

    );
  }
}