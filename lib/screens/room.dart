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
  List<Contribution> allContributions = [];
  int roomId;
  String userName;

  _RoomPageState(this.roomId);

  @override
  void initState() {
    Preferences().getUserName().then((n) => userName = n);
    allContributions.add(new Contribution(01, "lib/assets/antwort_icon.png", 10));
    allContributions.add(new Contribution(01, "lib/assets/fragezeichen_icon.png", 10));
    super.initState();
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return new Container(
      padding: EdgeInsets.only(left: 65, right: 65, top: 5, bottom: 5),
      alignment: Alignment(0, 0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(width: 0.2),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            padding: EdgeInsets.all(12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        allContributions[index].type,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Ibrahim Dursun",
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                      },
                    ),
                  ),
                ]),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final num args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Room Page $args"),
        centerTitle: true,
        actions: [
          new IconButton(
            icon: new Image.asset('lib/assets/logo_projekt.png'),
            tooltip: 'Home',
            onPressed: () => setState(() {}),
          ),
        ],
      ),

      body: new Container(
          child: Column (
              children: [
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  width: 400,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Color(0xFF00206B)),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey,
                        offset: new Offset(10.0, 10.0),
                        blurRadius: 20.0,
                      )
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'lib/assets/discussion_icon.png',
                        height: 50,
                        width: 50,
                      ),
                      FutureBuilder<Room>(
                        future: Network().fetchRoom(roomId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 7, bottom: 7),
                                    child: Text(
                                      'Topic: ' + snapshot.data.topic,
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 0, bottom: 7),
                                    child: Text(
                                      'Meeting point: ' + snapshot.data.meetingPoint,
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError){
                            return Text("${snapshot.error}");
                          }

                          return CircularProgressIndicator();

                        },
                      ),
                    ],
                  ),


                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                  padding: const EdgeInsets.all(3.0),
                  width: 400,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: Color(0xFF00206B)),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey,
                          offset: new Offset(10.0, 10.0),
                          blurRadius: 20.0,
                        )
                        ],
                  ),
                  child: FutureBuilder<List<Contribution>>(
                    future: Network().fetchRoomContributions(new Room(roomId, null, null, null, null, null)),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Image.asset(
                              'lib/assets/speaker_icon.png',
                              height: 50,
                              width: 50,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Speaker: $userName",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Speaktime: 01:23",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),

                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return CircularProgressIndicator();
                    },
                  ),
                ),

                Expanded(
                  child: new ListView.builder(
                     itemBuilder: _buildProductItem,
                     itemCount: allContributions.length,
                  ),
                ),
              ]
          )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return ContributionDialog(this.allContributions);
              });
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}