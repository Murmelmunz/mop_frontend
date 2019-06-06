import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speechlist/main.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/utils/network.dart';
import 'package:speechlist/widgets/box_with_title.dart';

class CreateRoomPage3 extends StatefulWidget {
  static const String routeName = "/create_room3";
  final Room room;

  CreateRoomPage3({Key key, this.room}) : super(key: key);

  @override
  _CreateRoomPageState3 createState() => _CreateRoomPageState3(this.room);
}

class _CreateRoomPageState3 extends State<CreateRoomPage3> {
  bool _isLoading = false;
  String _error;
  Room room;

  _CreateRoomPageState3(this.room);

  Future _createRoom() async {
    setState(() { _isLoading = true; });
    try {
      Room room = await Network().createRoom(this.room);
      Navigator.of(context).popAndPushNamed('/room', arguments: room.roomId);
    } catch (e) {
      print(e.toString());
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create Room"),),

        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: <Widget>[
            Container(
              color: MyApp.PrimaryColorLight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_left),
                    onPressed: () => Navigator.of(context).pushReplacementNamed(
                        "/create_room2",
                        arguments: this.room
                    ),
                    color: Colors.white,
                  ),

                  Text("Overview", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)), //style: Theme.of(context).textTheme.title
                  IconButton(icon: Icon(Icons.arrow_right), color: Colors.white,),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                children: <Widget>[
                  BoxWithTitle(
                    title: "Room Information",
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 10,
                        direction: Axis.vertical,
                        children: <Widget>[
                          Text("Topic: ${room.topic}"),
                          Text("Meeting point: ${room.meetingPoint}"),
                          Text("Date: ${room.date}"),
                          Text("Time: ${room.time}"),
                          room.password != null
                              ? Icon(Icons.lock, color: Theme.of(context).accentColor)
                              : Container()
                        ],
                      ),
                    ),
                  ),

                  BoxWithTitle(
                    title: "Categories",
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 10,
                        direction: Axis.vertical,
                        children: <Widget>[
                          Text("Topic: ${room.topic}"),
                          Text("Meeting point: ${room.meetingPoint}"),
                          Text("Date: ${room.date}"),
                          Text("Time: ${room.time}"),
                          room.password != null
                              ? Icon(Icons.lock, color: Theme.of(context).accentColor)
                              : Container()
                        ],
                      ),
                    ),
                  ),

                  RaisedButton(onPressed: _createRoom, child: Text('Create Room'),),
                  Padding(padding: EdgeInsets.all(8.0)),

                  _error != null ? Text(_error) : Text(""),
                  Padding(padding: EdgeInsets.all(8.0)),
                  
                ],
              ),
            ),

          ],
        )

    );
  }
}