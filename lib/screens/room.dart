import 'package:flutter/material.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/utils/network.dart';
import 'package:speechlist/utils/preferences.dart';
import 'package:speechlist/widgets/contribution_dialog.dart';

class RoomPage extends StatefulWidget {
  static const String routeName = "/room";
  final int roomId;

  RoomPage(this.roomId);

  @override
  _RoomPageState createState() => _RoomPageState(this.roomId);
}

class _RoomPageState extends State<RoomPage> {
  int roomId;
  String userName;

  _RoomPageState(this.roomId);

  @override
  void initState() {
    Preferences().getUserName().then((n) => userName = n);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final num args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Room Page $args"),),

      body: FutureBuilder<Room>(
        future: Network().fetchRoom(roomId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(snapshot.data.topic),
                Text(snapshot.data.meetingPoint),
                Text("${snapshot.data.roomId}"),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: snapshot.data.categories.map(
                          (item) => Row(children: item.map(
                              (item2) => Text("${item2}, ")
                          ).toList(),)
                  ).toList(),
                ),

                // FutureBuilder will reload data
                RaisedButton(onPressed: () => setState(() {}), child: Text('Refresh'),),
                Text("Your Name: $userName"),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return ContributionDialog();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}