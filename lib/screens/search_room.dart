import 'package:flutter/material.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/utils/network.dart';
import 'package:speechlist/widgets/rooms_list.dart';

// Start of search room with identification
class SearchRoomPage extends StatefulWidget {
  static const String routeName = "/search_room";

  SearchRoomPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

// Start of creating the Screen. You find methods which are needed for the implementation. First of all
// all variables will be declared. Then you find the help methods. At the end there are the flutter return widgets
class _MyHomePageState extends State<SearchRoomPage> {
  TextEditingController editingController = TextEditingController();
  final duplicateItems = List<Room>();
  var items = List<Room>();

  @override
  void initState() {
    new Network().fetchAllRooms().then((a) {
      duplicateItems.addAll(a);
      items.addAll(a);
      setState(() {});
    });
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Room> dummySearchList = List<Room>();
    dummySearchList.addAll(duplicateItems);

    if (query.isNotEmpty) {
      List<Room> dummyListData = List<Room>();

      dummySearchList.forEach((item) {
        if (item.topic.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });

      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });

      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'SpeechList',
          style: new TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          new IconButton(
            icon: new Image.asset('lib/assets/logo_projekt.png'),
            tooltip: 'Home',
            onPressed: () {
              Navigator.of(context).pushNamed('/search_room');
              setState(() {});
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  labelStyle: TextStyle(
                    color: const Color(0xFF00206B),
                  ),
                ),
              ),
            ),
            RoomsList(items),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/create_room', arguments: 456);
        },
        backgroundColor: const Color(0xFF00206B),
        child: Icon(Icons.add),
      ),
    );
  }
}
