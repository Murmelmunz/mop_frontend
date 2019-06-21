import 'package:flutter/material.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/utils/network.dart';
import 'package:speechlist/widgets/rooms_list.dart';

// Start of search room with identification
class SearchRoomPage extends StatefulWidget {
  static const String routeName = "/search_room";
  final String title;

  SearchRoomPage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

// Start of creating the Screen. You find methods which are needed for the implementation. First of all
// all variables will be declared. Then you find the help methods. At the end there are the flutter return widgets
class _MyHomePageState extends State<SearchRoomPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      body: Container(
        child: RefreshIndicator(
          onRefresh: () async => setState(() {}),
          child: FutureBuilder<List<Room>>(
            future: Network().fetchAllRooms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return RoomsList(snapshot.data);
              }
              return ListView(children: <Widget>[Text("${snapshot.error}")]);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/create_room', arguments: Room(null, "", "", "", "", null));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
