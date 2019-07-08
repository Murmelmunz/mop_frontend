import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speechlist/models/contribution.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/models/user.dart';
import 'package:speechlist/utils/network.dart';
import 'package:speechlist/utils/preferences.dart';

class RoomPage extends StatefulWidget {
  static const String routeName = "/room";
  final int roomId;

  RoomPage(this.roomId);

  @override
  _RoomPageState createState() => _RoomPageState(this.roomId);
}

class _RoomPageState extends State<RoomPage> {
  List<Contribution> allContributions = [];
  Room room;
  int roomId;
  String userName;
  int counterForTime = 0;
  Timer _timer;
  bool _isButtonDisabledStart = false;
  bool _isButtonDisabledStop = true;

  _RoomPageState(this.roomId);

  @override
  void initState() {
    Preferences().getUserName().then((n) => userName = n);
    super.initState();
  }

  Widget _buildButton(bool stopOrStartClock){
    if(stopOrStartClock){
      return IconButton(
        color: Color(0xFF00206B),
        icon: Icon(Icons.access_alarm),
        onPressed: _isButtonDisabledStart ? null : () {
          _isButtonDisabledStart = !_isButtonDisabledStart;
          _isButtonDisabledStop = !_isButtonDisabledStop;
          _timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
            counterForTime++;
            setState(() {});

          });

          Contribution lastContribution = room.contributions.first;
          Network().setRoomContributionStartTime(room, lastContribution, User(lastContribution.userId, lastContribution.name, ""), 0);
          setState(() {});
        },
      );
    } else {
      return IconButton(
        color: Color(0xFF00206B),
        icon: Icon(Icons.stop),
        onPressed: _isButtonDisabledStop ? null : () async {
          _isButtonDisabledStart = !_isButtonDisabledStart;
          _isButtonDisabledStop = !_isButtonDisabledStop;
          _timer.cancel();

          Contribution lastContribution = room.contributions.first;
          Network().setRoomContributionStopTime(room, lastContribution, User(lastContribution.userId, lastContribution.name, ""), counterForTime);
          await Network().removeRoomContribution(room, lastContribution, User(lastContribution.userId, lastContribution.name, ""));

          counterForTime = 0;

          setState(() {});
        },
      );
    }
  }

  Widget _getSpeaker(Room room, List<Contribution> contributions){
    if(contributions.length == 0){
      return Container(
        padding: EdgeInsets.all(5),
        child: RichText(
          text: new TextSpan(
            style: new TextStyle(
              fontSize: 16,
              color: Color(0xFF00206B),
            ),
            children: <TextSpan>[
              new TextSpan(text: 'Speaker: ', style: new TextStyle(fontWeight: FontWeight.bold)),
              new TextSpan(text: 'Nobody')
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(5),
        child: RichText(
          text: new TextSpan(
            style: new TextStyle(
              fontSize: 16,
              color: Color(0xFF00206B),
            ),
            children: <TextSpan>[
              new TextSpan(text: 'Speaker: ', style: new TextStyle(fontWeight: FontWeight.bold)),
              new TextSpan(text: contributions.first.name)
            ],
          ),
        ),
      );
    }
  }

  Widget _buildProductItem(BuildContext context, int index, List<Contribution> contributions) {

    if(contributions.length == 0){
      return Container();
    }else {
      return Container(
        padding: EdgeInsets.only(left: 65, right: 65, top: 5, bottom: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(width: 0.2),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,

          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child:
                    Column(children: <Widget>[
                      Image.asset(
                        contributions[index].type,
                        height: 35,
                        width: 35,
                      ),

                    ],
                    ),
                  ),

                  Expanded(
                    child: Column(children: <Widget>[
                      Text(
                        contributions[index].name,
                      ),
                    ],),),

                ]),
          ),

        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    final num args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: new AppBar(
        title: new Image.asset(
          'lib/assets/logo_speechlist_name.png',
          height: 30,
          width: 100,
        ),
        centerTitle: true,
        actions: [
          new IconButton(
            icon: new Icon(
                Icons.update
            ),
            tooltip: 'Home',
            onPressed: () {
              Timer _newTimer = new Timer.periodic(Duration(seconds: 3), (Timer timer) {
                setState(() {
                });
              });
              } ,
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
                              this.room = snapshot.data;
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
                          margin: EdgeInsets.all(2),
                          child: IconButton(
                            color: Color(0xFF00206B),
                            icon: Icon(Icons.launch),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/evaluate_room', arguments: room);
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
                  child: FutureBuilder<Room>(
                    future: Network().fetchRoom(roomId),
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

                          Expanded(
                            child: Column(
                              children: <Widget>[
                                _getSpeaker(snapshot.data, snapshot.data.contributions),
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
                                        new TextSpan(text: '$counterForTime' + ' seconds')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),


                            Column(children: <Widget>[
                              _buildButton(true),
                              _buildButton(false),
                            ],),


                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return CircularProgressIndicator();
                    },
                  ),
                ),


                FutureBuilder<Room>(
                  future: Network().fetchRoom(roomId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      return Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, int) =>
                              _buildProductItem(
                                  context, int, snapshot.data.contributions),
                          itemCount: snapshot.data.contributions.length,
                        ),
                      );

                    } else {

                      return Container();

                    }
                  }
                ),
              ]
          )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed('/contribute_room', arguments: this.allContributions);
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}