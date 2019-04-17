import 'package:flutter/material.dart';

class SearchRoomPage extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search Room"),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Search Room...",
            style: new TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/room');
            },
            child: Text('Room'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/room', arguments: 123);
            },
            child: Text('Room 123'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/room', arguments: 456);
            },
            child: Text('Room 456'),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/create_room');
        },
        tooltip: 'Create New Room',
        child: Icon(Icons.add),
      ),
    );
  }
}