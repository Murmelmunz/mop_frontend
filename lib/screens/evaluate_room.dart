import 'package:flutter/material.dart';
import 'package:speechlist/utils/preferences.dart';

class EvaluateRoomPage extends StatefulWidget {
  static const String routeName = "/evaluate_room";
  final int room;


  EvaluateRoomPage({Key key, this.room}) : super (key: key);

  @override
  _EvaluateRoomPageState createState() => _EvaluateRoomPageState(this.room);
}

class _EvaluateRoomPageState extends State<EvaluateRoomPage> {
  int roomId;
  String userName;

  _EvaluateRoomPageState(this.roomId);

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
            icon: new Image.asset('lib/assets/logo_projekt.png'),
            tooltip: 'Home',
            onPressed: () => setState(() {}),
          ),
        ],
      ),


      body: new Container(

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