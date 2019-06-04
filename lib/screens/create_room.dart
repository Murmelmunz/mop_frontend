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
  var _dateController = new TextEditingController();
  var _timeController = new TextEditingController();

  Future _createRoom() async {
    setState(() { _isLoading = true; });
    try {
      Room room = await Network().createRoom(
        Room(null, _topic, _meetingPoint, _dateController.text, _timeController.text)
      );
      Navigator.of(context).popAndPushNamed('/room', arguments: room.roomId);
    } catch (e) {
      print(e.toString());
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _pickDate() async {
    _date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030)
    ) ?? _date;
    _dateController.text = DateFormat('dd.MM.yy').format(_date);
    setState(() {});
  }

  Future<void> _pickTime() async {
    _time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    ) ?? _time;
    _timeController.text = _time.format(context);
    setState(() {});
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
                Text("Generic Settings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),

                IconButton(icon: Icon(Icons.arrow_right),
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                      "/create_room2",
                      arguments: Room(null, _topic, _meetingPoint, _dateController.text, _timeController.text)
                  ),
                  color: Colors.white,
                ),
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

                  GestureDetector(
                    onTap: () => _pickDate(),
                    child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(labelText: "Date", prefixIcon: Icon(Icons.event)),
                          controller: _dateController,
                        )
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),

                  GestureDetector(
                    onTap: () => _pickTime(),
                    child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(labelText: "Time", prefixIcon: Icon(Icons.access_time)),
                          controller: _timeController,
                        ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),

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