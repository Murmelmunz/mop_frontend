import 'package:flutter/material.dart';
import 'package:speechlist/models/contribution.dart';
import 'package:speechlist/models/room.dart';
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
  int roomId;
  String userName;

  _RoomPageState(this.roomId);

  @override
  void initState() {
    Preferences().getUserName().then((n) => userName = n);
    allContributions.add(new Contribution(2909, "lib/assets/antwort_icon.png", "Klaus"));
    allContributions.add(new Contribution(0507, "lib/assets/fragezeichen_icon.png", "Peter"));
    super.initState();
  }

  Widget _buildProductItem(BuildContext context, int index) {

    if(allContributions.length == 0){
      return Container();
    }else {
      return new Container(
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
                        allContributions[index].type,
                        height: 35,
                        width: 35,
                      ),

                    ],),),

                  Container(
                    margin: EdgeInsets.only(right: 40),
                    child: Column(children: <Widget>[
                      Text(
                        "${allContributions[index].id}",
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
                            icon: Icon(Icons.launch),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/evaluate_room', arguments: roomId);
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
                    future: Network().fetchRoomContributions(new Room(roomId, null, null, null, null, null, null)),
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
                                      new TextSpan(text: '${allContributions[0].id}')
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
                                allContributions.removeAt(0);
                                setState(() {

                                });
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

                Expanded(child:
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: _buildProductItem,
                    itemCount: allContributions.length,
                  ),
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