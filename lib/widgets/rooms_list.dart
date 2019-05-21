import 'package:flutter/material.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/widgets/join_dialog.dart';

class RoomsList extends StatelessWidget {
  List<Room> items;

  RoomsList(this.items);

  Widget build(context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
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
                            'Topic: ' + '${items[index].topic}',
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
                            'ID: ' + '${items[index].roomId}',
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
                            'Meeting point: ' + '${items[index].meetingPoint}',
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
                            'Person count: ' + '${items[index]}',
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
                                  builder: (BuildContext context) {
                                    return JoinDialog(items[index]);
                                  });
                            },
                          ),
                        ),
                      ]),
                )),
          );
        },
      ),
    );
  }
}
