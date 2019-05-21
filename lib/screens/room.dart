import 'package:flutter/material.dart';
import 'package:speechlist/main.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/utils/network.dart';

class RoomPage extends StatefulWidget {
  static const String routeName = "/room";
  final int roomId;

  RoomPage(this.roomId);

  @override
  _RoomPageState createState() => _RoomPageState(this.roomId);
}

class _RoomPageState extends State<RoomPage> {
  int roomId;

  _RoomPageState(this.roomId);

  @override
  Widget build(BuildContext context) {
    final num args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Room Page $args"),
        backgroundColor: MyApp.PrimaryColor,
      ),

      body: FutureBuilder<Room>(
        future: Network().fetchRoom(roomId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(snapshot.data.topic),
                Text(snapshot.data.meetingPoint),
                Text("${snapshot.data.roomId}"),

                // FutureBuilder will reload data
                RaisedButton(onPressed: () => setState(() {}), child: Text('Refresh'),),
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