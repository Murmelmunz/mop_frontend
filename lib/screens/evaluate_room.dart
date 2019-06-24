import 'package:flutter/material.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/utils/preferences.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

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

  List<CircularStackEntry> circularData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(700.0, Color(0xff00206B), rankKey: 'Q1'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  Material myCircularItems(String title, String subtitle){
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(title,style:TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFF00206B),
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Text(subtitle,style:TextStyle(
                      fontSize: 20.0,
                    ),),
                  ),

                  Padding(
                    padding:EdgeInsets.all(8.0),
                    child:AnimatedCircularChart(
                      size: const Size(120.0, 120.0),
                      initialChartData: circularData,
                      chartType: CircularChartType.Pie,
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//  Material myTextItems(String title, String subtitle){
//    return Material(
//      color: Colors.white,
//      elevation: 14.0,
//      borderRadius: BorderRadius.circular(24.0),
//      shadowColor: Color(0x802196F3),
//      child: Center(
//        child:Padding(
//          padding: EdgeInsets.all(8.0),
//          child: Row(
//            mainAxisAlignment:MainAxisAlignment.center,
//            children: <Widget>[
//              Column(
//                mainAxisAlignment:MainAxisAlignment.center,
//                children: <Widget>[
//
//                  Padding(
//                    padding: EdgeInsets.all(8.0),
//                    child:Text(title,style:TextStyle(
//                      fontSize: 20.0,
//                      color: Colors.blueAccent,
//                    ),),
//                  ),
//
//                  Padding(
//                    padding: EdgeInsets.all(8.0),
//                    child:Text(subtitle,style:TextStyle(
//                      fontSize: 30.0,
//                    ),),
//                  ),
//
//                ],
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }

  @override
  void initState() {
    Preferences().getUserName().then((n) => userName = n);
    super.initState();
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


          body: new Container(
                color:Color(0xffE5E5E5),
                child:StaggeredGridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                children: <Widget>[
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: myCircularItems("Quarterly speak time", roomId.topic),
                ),
//                Padding(
//                padding: const EdgeInsets.only(right:8.0),
//                child: myTextItems("Mktg. Spend","48.6M"),
//                ),
//                Padding(
//                padding: const EdgeInsets.only(right:8.0),
//                child: myTextItems("Users","25.5M"),
//                ),

        ],
        staggeredTiles: [
        StaggeredTile.extent(4, 250.0),
        StaggeredTile.extent(2, 250.0),
        StaggeredTile.extent(2, 120.0),
        StaggeredTile.extent(2, 120.0),
        StaggeredTile.extent(4, 250.0),
    ]),
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