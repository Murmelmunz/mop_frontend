import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/utils/network.dart';

class CreateRoomPage extends StatefulWidget {
  static const String routeName = "/create_room";
  final String title;

  CreateRoomPage({Key key, this.title}) : super(key: key);

  @override
  _CreateRoomPageState createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  bool _isLoading = false;
  String _error;

  String _topic = "";
  String _meetingPoint = "";
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  Future _createRoom() async {
    setState(() { _isLoading = true; });
    try {
      Room room = await Network().createRoom(Room(null, _topic, _meetingPoint));
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
      appBar: AppBar(title: Text(widget.title),),

      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
        padding: EdgeInsets.only(left:10, right:10, top:5, bottom:5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(decoration: InputDecoration(labelText: "Topic"),
                onChanged: (text) { setState(() { _topic = text; }); },),
              Padding(padding: EdgeInsets.all(8.0)),

              TextField(decoration: InputDecoration(labelText: "Meeting point"),
                onChanged: (text) { setState(() { _meetingPoint = text; }); },),
              Padding(padding: EdgeInsets.all(8.0)),

              Row(children: <Widget>[
                Text("Date: "),
                RaisedButton(child: Text(DateFormat('dd.MM.yy').format(_date)),
                    onPressed: () async { _date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2018), lastDate: DateTime(2030)); setState(() {}); }
                ),
                Icon(Icons.event),
              ],),
              Padding(padding: EdgeInsets.all(8.0)),

              Row(children: <Widget>[
                Text("Time: "),
                RaisedButton(child: Text(_time.format(context)),
                    onPressed: () async { _time = await showTimePicker(context: context, initialTime: TimeOfDay.now()); setState(() {}); }
                ),
                Icon(Icons.access_time),
              ],),
              Padding(padding: EdgeInsets.all(80.0)),

              RaisedButton(onPressed: _createRoom, child: Text('Create Room'),),

              _error != null ? Text(_error) : Text("")
            ],
          ),
        ),
      )
    );
  }
}