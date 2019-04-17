import 'package:flutter/material.dart';

class RoomPage extends StatelessWidget {
  static const String routeName = "/room";

  @override
  Widget build(BuildContext context) {
    final num args = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Room Page $args"),
        backgroundColor: Colors.blue,
      ),

      body: new Container(
        // Center the content
        child: new Center(
          child: new Column(
            // Center content in the column
            mainAxisAlignment: MainAxisAlignment.center,
            // add children to the column
            children: <Widget>[
              // Text
              new Text(
                "Room Page",
                // Setting the style for the Text
                style: new TextStyle(fontSize: 20.0),
                // Set text alignment to center
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}