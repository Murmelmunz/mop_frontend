import 'package:flutter/material.dart';
import 'package:speechlist/models/category.dart';
import 'package:speechlist/models/evaluated_contribution.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/models/value.dart';
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
  Room room;
  String userName;
  List<EvaluatedContribution> settedList;
  List<Category> tranformList;
  double reciprocal(double d) => 1/d;
  List<Color> colors = new List<Color>();

  _EvaluateRoomPageState(this.room);

  @override
  void initState() {
    colors.add(new Color(0xff00206B));
    colors.add(new Color(0xffFF0000));
    colors.add(new Color(0xffFFA500));
    colors.add(new Color(0xffFFFF00));
    colors.add(new Color(0xff228B22));
    colors.add(new Color(0xff00FFFF));
    colors.add(new Color(0xffFF00FF));
    colors.add(new Color(0xff8A2BE2));
    Preferences().getUserName().then((n) => userName = n);
    super.initState();
  }

  void setupData(List<EvaluatedContribution> allData){
      tranformList = this.room.categories;
      for(EvaluatedContribution contribution in allData){
        for(Category evaCat in contribution.categories){
          for (Value evaVal in evaCat.values){
            for(Category cat in tranformList){
              for(Value val in cat.values){
                if(cat.name == evaCat.name){
                  if(evaVal.value == val.value){
                    val.time += contribution.time;
                  }
                }
              }
            }
          }
        }
      }

  }

  List<CircularStackEntry> getCircularData(List<Value> categories){
    List<CircularStackEntry> circularData = new List<CircularStackEntry>();
    List<CircularSegmentEntry> helper = new List<CircularSegmentEntry>();
    int index = 0;
    for(Value category in categories){
      if(category.time == 0){
        helper.add(new CircularSegmentEntry(0.0, colors[index], rankKey: "Q" + index.toString()));
      } else{
        helper.add(new CircularSegmentEntry(category.time.toDouble(), colors[index], rankKey: "Q" + index.toString()));
      }
      index = index + 1;
    }
    CircularStackEntry entry = new CircularStackEntry(helper, rankKey: "Quarterly Speak Time");
    circularData.add(entry);
    return circularData;
  }

  Widget _buildStatistic(BuildContext context, int index){
    return Container(
      padding: EdgeInsets.all(15),
      child: myCircularItems("Quarterly speak time", index)
      ,
    );
  }

  Widget _buildLabel(BuildContext context, int index, List<Value> values){
    return Row(children: <Widget>[
      Container(
        padding: EdgeInsets.only(right: 5, top: 1),
        child: IconTheme(
          data: new IconThemeData(
              color: colors[index]),
          child: Icon(Icons.color_lens),
        ),
      ),
      Container(
          child: Text(values[index].value),
        )
    ],
    );

  }

  Material myCircularItems(String title, int index){
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
                    padding: EdgeInsets.all(5.0),
                    child:Text(
                      room.categories[index].name,
                      style:TextStyle(
                        fontSize: 18.0,
                    ),),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:EdgeInsets.all(10),
                        child:AnimatedCircularChart(
                          size: const Size(100.0, 100.0),
                          initialChartData: getCircularData(this.tranformList[index].values),
                          chartType: CircularChartType.Pie,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 14, top: 2),
                          height: 100,
                          width: 140,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, int) => _buildLabel(context, int, room.categories[index].values),
                            itemCount: room.categories[index].values.length,
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
                              new TextSpan(text: '${room.topic}')
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
                              new TextSpan(text: '${room.meetingPoint}')
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
                              new TextSpan(text: '${room.date}')
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
                              new TextSpan(text: '${room.time}')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  child: FutureBuilder<List<EvaluatedContribution>>(
                    future: Network().fetchRoomEvaluation(this.room.roomId),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        this.settedList = snapshot.data;
                        setupData(settedList);
                        return Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, int) => _buildStatistic(context, int),
                              itemCount: room.categories.length,
                          ),
                        );
                      } else {
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
              builder: (context) {return Container();});
        },
        child: Icon(
            Icons.save,
        ),
      ),
    );
  }
}