import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class CreateRoomPage extends StatefulWidget {
  static const String routeName = "/create_room";

  CreateRoomPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreateRoomPageState createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  bool _isLoading = false;
  String _error;

  int _roomId = new Random().nextInt(9000);
  String _topic = "";
  String _meetingPoint = "";
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  Future _createRoom() async {
    setState(() { _isLoading = true; });
    try {
//      final response = await http.put(
//          //Uri.encodeFull('https://jsonplaceholder.typicode.com/todos/1'),
//          Uri.encodeFull('http://10.0.2.2:3000/test/1'),
//          body: '{"a": 101, "b": 202, "c":303}',
//          headers: {"Content-Type": "application/json"})
//        .timeout(Duration(milliseconds: 5000));

      final response = await http.post(
          Uri.encodeFull('http://10.0.2.2:3000/room'),
          body: '{"roomId": $_roomId, "topic": "$_topic", "meetingPoint": "$_meetingPoint", "date": "$_date", "time": "$_time"}',
          headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

//      final response = await http.delete(
//        //Uri.encodeFull('https://jsonplaceholder.typicode.com/todos/1'),
//          Uri.encodeFull('http://10.0.2.2:3000/test/0'),
//          headers: {"Content-Type": "application/json"})
//        .timeout(Duration(milliseconds: 5000));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("success: " + response.body);
        Navigator.of(context).popAndPushNamed('/room', arguments: _roomId);
      } else {
        throw('error: ${response.statusCode}');
      }
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
              TextField(decoration: InputDecoration(hintText: "Topic"),
                onChanged: (text) { setState(() { _topic = text; }); },),
              Padding(padding: EdgeInsets.all(8.0)),

              TextField(decoration: InputDecoration(hintText: "Meeting point"),
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