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
            padding: EdgeInsets.all(11),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(2.0),
                  width: 600,
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


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Align(
                          child: Image.asset(
                            'lib/assets/discussion_icon.png',
                            height: 50,
                            width: 50,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        margin: EdgeInsets.all(5),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5, left: 10, bottom: 5),
                        child: FutureBuilder<Room>(
                          future: Network().fetchRoom(roomId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: RichText(
                                        text: new TextSpan(
                                          style: new TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF00206B),
                                          ),
                                          children: <TextSpan>[
                                            new TextSpan(text: 'Topic: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                                            new TextSpan(text: '${snapshot.data.topic}')
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      child: RichText(
                                        text: new TextSpan(
                                          style: new TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF00206B),
                                          ),
                                          children: <TextSpan>[
                                            new TextSpan(text: 'Meeting point: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                                            new TextSpan(text: '${snapshot.data.meetingPoint}')
                                          ],
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
                      ),
                      Container(
                          margin: EdgeInsets.all(5),
                          child: IconButton(
                            color: Color(0xFF00206B),
                            icon: Icon(Icons.subdirectory_arrow_right),
                            onPressed: () {
                            },
                          ),
                      ),

                    ],
                  ),


                ),
                Container(
                  margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
                  padding: EdgeInsets.all(2.0),
                  width: 600,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: Color(0xFF00206B)),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey,
                          offset: new Offset(10.0, 10.0),
                          blurRadius: 10.0,
                        )
                        ],
                  ),
                  child: FutureBuilder<List<Contribution>>(
                    future: Network().fetchRoomContributions(new Room(roomId, null, null, null, null, null)),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                          Container(
                          margin: EdgeInsets.all(5),
                              child: Image.asset(
                                'lib/assets/speaker_icon.png',
                                height: 50,
                                width: 50,
                              ),
                          ),

                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                child: RichText(
                                  text: new TextSpan(
                                    style: new TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF00206B),
                                    ),
                                    children: <TextSpan>[
                                      new TextSpan(text: 'Speaker: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                                      new TextSpan(text: '${userName}')
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: RichText(
                                  text: new TextSpan(
                                    style: new TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF00206B),
                                    ),
                                    children: <TextSpan>[
                                      new TextSpan(text: 'Speaktime: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                                      new TextSpan(text: '01:32')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.all(5),
                            child: IconButton(
                              color: Color(0xFF00206B),
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                              },
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