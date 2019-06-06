import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speechlist/main.dart';
import 'package:speechlist/models/room.dart';

class CreateRoomPage extends StatefulWidget {
  static const String routeName = "/create_room";
  final Room room;

  CreateRoomPage({Key key, this.room}) : super(key: key);

  @override
  _CreateRoomPageState createState() => _CreateRoomPageState(this.room);
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  bool _isLoading = false;

  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  var _dateController = new TextEditingController();
  var _timeController = new TextEditingController();
  Room room;

  _CreateRoomPageState(this.room);

  @override
  void initState() {
    super.initState();
    _dateController.text = room.date;
    _timeController.text = room.time;
  }

  initialValue(val) {
    return TextEditingController(text: val);
  }

  Future<void> _pickDate() async {
    _date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030)
    ) ?? _date;
    room.date = _dateController.text = DateFormat('dd.MM.yy').format(_date);
    setState(() {});
  }

  Future<void> _pickTime() async {
    _time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    ) ?? _time;
    room.time = _timeController.text = _time.format(context);
    setState(() {});
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
                IconButton(icon: Icon(Icons.arrow_left), color: Colors.white,),
                Text("Generic Settings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),

                IconButton(icon: Icon(Icons.arrow_right),
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                      "/create_room2",
                      arguments: room
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
                    onChanged: (text) { room.topic = text; },
                    controller: initialValue(room.topic),
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),

                  TextField(decoration: InputDecoration(labelText: "Meeting point", prefixIcon: Icon(Icons.location_on)),
                    onChanged: (text) { room.meetingPoint = text; },
                    controller: initialValue(room.meetingPoint),
                  ),
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

                  TextField(decoration: InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.vpn_key)),
                    onChanged: (text) { room.password = text; },
                    controller: initialValue(room.password),
                    obscureText: true,
                  ),
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