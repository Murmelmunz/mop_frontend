import 'package:flutter/material.dart';
import 'package:speechlist/main.dart';
import 'package:speechlist/models/room.dart';

class CreateRoomPage2 extends StatefulWidget {
  static const String routeName = "/create_room2";
  final Room room;

  CreateRoomPage2({Key key, this.room}) : super(key: key);

  @override
  _CreateRoomPageState2 createState() => _CreateRoomPageState2(this.room);
}

class _CreateRoomPageState2 extends State<CreateRoomPage2> {
  bool _isLoading = false;
  String _error;
  Room room;

  _CreateRoomPageState2(this.room);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create Room"),),

        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: <Widget>[
            Container(
              color: MyApp.PrimaryColorLight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_left), onPressed: () => Navigator.of(context).pushReplacementNamed("/create_room"), color: Colors.white,),
                  Text("Categorie Selection", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)), //style: Theme.of(context).textTheme.title

                  IconButton(icon: Icon(Icons.arrow_right),
                    onPressed: () => Navigator.of(context).pushReplacementNamed(
                        "/create_room3",
                        arguments: this.room
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
            ),

          ],
        )

    );
  }
}