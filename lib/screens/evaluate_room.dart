import 'package:flutter/material.dart';
import 'package:speechlist/models/category.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/utils/network.dart';
import 'package:speechlist/utils/preferences.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:speechlist/widgets/box_with_title.dart';

class EvaluateRoomPage extends StatefulWidget {
  static const String routeName = "/evaluate_room";
  final Room room;

  EvaluateRoomPage({Key key, this.room}) : super (key: key);

  @override
  _EvaluateRoomPageState createState() => _EvaluateRoomPageState(this.room);
}

class _EvaluateRoomPageState extends State<EvaluateRoomPage> {
  Room roomId;
  String userName;
  var data1 = [0.0,-2.0,3.5,-2.0,0.5,0.7,0.8,1.0,2.0,3.0,3.2];

  _EvaluateRoomPageState(this.roomId);

  @override
  void initState() {
    Preferences().getUserName().then((n) => userName = n);
    super.initState();
  }

  List<CircularStackEntry> getCircularData(List<String> categories){
    List<CircularStackEntry> circularData = new List<CircularStackEntry>();
    for(String category in categories){
      CircularStackEntry entry = new CircularStackEntry(<CircularSegmentEntry> [new CircularSegmentEntry(700.0, Color(0xff00206B))]);
      circularData.add(entry);
    }
  }
  
  List<CircularStackEntry> circularData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(700.0, Color(0xff00206B), rankKey: 'Q1'),
        new CircularSegmentEntry(700.0, Color(0xff6783E6), rankKey: 'Q1'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  Widget _buildStatistic(BuildContext context, int index, List<Category> allCategories){
    return Container(
      padding: EdgeInsets.all(15),
      child: myCircularItems("Quarterly speak time", allCategories[index].name, index)
      ,
    );
  }

  Widget _buildLabel(BuildContext context, int index){
    return Container(
      child: Text("Text" + index.toString()),
    );
  }

  Material myCircularItems(String title, String subtitle, int index){
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child:Text(
                      title,
                      style:TextStyle(
                        fontSize: 23.0,
                      color: Color(0xFF00206B),
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(3.0),
                    child:Text(
                      subtitle,
                      style:TextStyle(
                        fontSize: 18.0,
                    ),),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:EdgeInsets.all(5),
                        child:AnimatedCircularChart(
                          size: const Size(100.0, 100.0),
                          initialChartData: circularData,
                          chartType: CircularChartType.Pie,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 10),
                        height: 100,
                        width: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, int) => _buildLabel(context, int),
                          itemCount: 4,
                        )
                      ),

                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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


          body:
              Column(children:
              <Widget>[
                BoxWithTitle(
                  title: "Room Information",
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      spacing: 10,
                      direction: Axis.vertical,
                      children: <Widget>[
                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 18,
                              color: Color(0xFF00206B),
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Topic: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                              new TextSpan(text: '${roomId.topic}')
                            ],
                          ),
                        ),
                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 16,
                              color: Color(0xFF00206B),
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Meeting point: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                              new TextSpan(text: '${roomId.meetingPoint}')
                            ],
                          ),
                        ),
                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 14,
                              color: Color(0xFF00206B),
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Date: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                              new TextSpan(text: '${roomId.date}')
                            ],
                          ),
                        ),
                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 13,
                              color: Color(0xFF00206B),
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Time: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                              new TextSpan(text: '${roomId.time}')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: FutureBuilder<Room>(
                    future: Network().fetchRoom(this.roomId.roomId),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        List<Category> allCategories = snapshot.data.categories;
                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, int) => _buildStatistic(context, int, allCategories),
                            itemCount: 3,
                          ),
                        );
                      } else{
                        return Container();
                      }
                    },
                  ),
                ),

              ],
              ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {});
        },
        child: Icon(
            Icons.save,
        ),
      ),
    );
  }
}