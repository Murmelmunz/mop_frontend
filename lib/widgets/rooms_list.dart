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
    setPathForPW();
    super.initState();
  }

  void setPathForPW(){
    items.forEach((item) {
      if(item.password != ""){
        item.password = 'lib/assets/Schloss_Icon_Geschlossen.png';
      } else{
        item.password = 'lib/assets/schloss_icon_offen.png';
      }
    });
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
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemsFiltered.length,
            itemBuilder: (context, index) {
              bool last = itemsFiltered.length == (index + 1);

              return new Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: last ? 80 : 5),
                alignment: Alignment(0, 0),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(
                          width: 1,
                          color: Color(0xFF00206B),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                          textDirection: TextDirection.rtl,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment(-0.86, 0),
                                  padding: EdgeInsets.only(top: 10, bottom: 5, left: 15),
                                  child: Text(
                                    'Topic: ' + '${itemsFiltered[index].topic}',
                                    style: TextStyle(
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Align(
                                    child: Image.asset(
                                      itemsFiltered[index].password,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(top: 10, bottom: 5, right: 15),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top:5, bottom: 5, left: 15),
                                  child: Text(
                                    'ID: ' + '${itemsFiltered[index].roomId}',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top:5, bottom: 5, left: 15),
                                  child: Text(
                                    'Meeting point: ' + '${itemsFiltered[index].meetingPoint}',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top:5, bottom: 5, left: 15),
                                  child: Text(
                                    'Person count: TODO',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment(1, 0),
                              child: new IconButton(
                                icon: new Icon(
                                  Icons.arrow_right,
                                  color: Color(0xFF00206B),
                                ),
                                tooltip: 'Expand for more Information',
                                iconSize: 35,
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
        ),
      ],
    );
  }
}