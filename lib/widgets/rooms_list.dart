import 'package:flutter/material.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/widgets/join_dialog.dart';

class RoomsList extends StatefulWidget {
  final List<Room> items;
  RoomsList(this.items, {Key key}) : super(key: key);

  @override
  _RoomsListState createState() => new _RoomsListState(this.items);
}

class _RoomsListState extends State<RoomsList> {
  List<Room> items;
  _RoomsListState(this.items);

  var itemsFiltered = List<Room>();
  var editingController = TextEditingController();

  @override
  void initState() {
    itemsFiltered.addAll(items);
    super.initState();
  }

  void filterSearchResults(String query) {
    itemsFiltered.clear();

    if (query.isNotEmpty) {
      items.forEach((item) {
        if (item.topic.toLowerCase().contains(query.toLowerCase())) {
          itemsFiltered.add(item);
        }
      });
    } else {
      itemsFiltered.addAll(items);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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

        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemsFiltered.length,
            itemBuilder: (context, index) {
              return new Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                alignment: Alignment(0, 0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(width: 0.2),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                          textDirection: TextDirection.rtl,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              alignment: Alignment(-0.93, 0),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Topic: ' + '${itemsFiltered[index].topic}',
                                style: TextStyle(
                                  color: const Color(0xFF00206B),
                                  fontSize: 19,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment(-0.93, 0),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'ID: ' + '${itemsFiltered[index].roomId}',
                                style: TextStyle(
                                  color: const Color(0xFF00206B),
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment(-0.91, 0),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Meeting point: ' + '${itemsFiltered[index].meetingPoint}',
                                style: TextStyle(
                                  color: const Color(0xFF00206B),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment(-0.91, 0),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Person count: ' + '${itemsFiltered[index]}',
                                style: TextStyle(
                                  color: const Color(0xFF00206B),
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment(1, 0),
                              child: new IconButton(
                                icon: new Icon(Icons.arrow_drop_down),
                                tooltip: 'Expand for more Information',
                                iconSize: 30,
                                color: const Color(0xFF00206B),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return JoinDialog(itemsFiltered[index]);
                                      });
                                },
                              ),
                            ),
                          ]),
                    )),
              );
            },
          ),
        )
      ],
    );
  }
}