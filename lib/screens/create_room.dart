import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speechlist/main.dart';
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
          : Column(
        children: <Widget>[
          Container(
            color: MyApp.PrimaryColorLight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_left), onPressed: () {}, color: Colors.white,),
                Text("Generic Settings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)), //style: Theme.of(context).textTheme.title
                IconButton(icon: Icon(Icons.arrow_right), onPressed: () {}, color: Colors.white,),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(8.0)),

                  TextField(decoration: InputDecoration(labelText: "Topic", prefixIcon: Icon(Icons.chat_bubble)),
                    onChanged: (text) { setState(() { _topic = text; }); },),
                  Padding(padding: EdgeInsets.all(8.0)),

                  TextField(decoration: InputDecoration(labelText: "Meeting point", prefixIcon: Icon(Icons.location_on)),
                    onChanged: (text) { setState(() { _meetingPoint = text; }); },),
                  Padding(padding: EdgeInsets.all(8.0)),

                  Row(children: <Widget>[
                    Text("Date: "),
                    RaisedButton(child: Text(DateFormat('dd.MM.yy').format(_date)),
                        onPressed: () async { _date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2018), lastDate: DateTime(2030)); setState(() {}); }
                    ),
                    Icon(Icons.event),
                  ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                  Padding(padding: EdgeInsets.all(8.0)),

                  Row(children: <Widget>[
                    Text("Time: "),
                    RaisedButton(child: Text(_time.format(context)),
                        onPressed: () async { _time = await showTimePicker(context: context, initialTime: TimeOfDay.now()); setState(() {}); }
                    ),
                    Icon(Icons.access_time),
                  ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                  Padding(padding: EdgeInsets.all(40.0)),

                  RaisedButton(onPressed: _createRoom, child: Text('Create Room'),),
                  Padding(padding: EdgeInsets.all(8.0)),

                  _error != null ? Text(_error) : Text(""),
                  Padding(padding: EdgeInsets.all(8.0)),

                ],
              ),
            ),
          ),
        ],
      )

    );
  }
}