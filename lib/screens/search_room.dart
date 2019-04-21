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

      body: new Container(
          padding: new EdgeInsets.all(10.0),
          child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              TextField(
                  decoration: InputDecoration(
                      hintText: 'Please enter a search term'
                  ),
              ),
              new Card(
                color: Colors.white70,
                child: new Container(
                  padding: new EdgeInsets.all(10.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [ //Padding between these please
                      new Text("I love Flutter", style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      new Icon(Icons.favorite, color: Colors.redAccent, size: 50.0)
              ]
          )
    )
    )
    ]
    )
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