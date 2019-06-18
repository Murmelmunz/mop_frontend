import 'package:flutter/material.dart';
import 'package:speechlist/models/contribution.dart';
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

      body: Column(
        children: <Widget>[
          FutureBuilder<Room>(
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
                        (item) => Row(
                            children: [
                              Text("${item.name}: "),
                              Row(
                                children: item.values.map(
                                    (value) => Text("${value.name}, ")
                                ).toList()
                              ),
                            ]
                        )
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

          Padding(padding: EdgeInsets.all(20.0),),

          FutureBuilder<List<Contribution>>(
            future: Network().fetchRoomContributions(new Room(roomId, null, null, null, null, null)),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Column(
                      children: snapshot.data.map(
                          (item) => Text("type: ${item.type}, userId: ${item.userId}")
                      ).toList(),
                    ),

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
        ],
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