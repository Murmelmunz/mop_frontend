import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speechlist/main.dart';  // use for colors?
import 'package:speechlist/models/room.dart';
import 'package:speechlist/widgets/contribution_dialog.dart';

class DiscussionRoomPage extends StatefulWidget {
  static const String routeName = "/discussion_room";
  final Room room;

  DiscussionRoomPage({Key key, this.room}) : super(key: key);

  @override
  _DiscussionRoomPageState createState() => _DiscussionRoomPageState(this.room);
}

class _DiscussionRoomPageState extends State<DiscussionRoomPage> {
  Room room;

  _DiscussionRoomPageState(this.room);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('SpeechList',),
        centerTitle: true,
        actions: [
          new IconButton(
            icon: new Image.asset('lib/assets/logo_projekt.png'),
            tooltip: 'Home',
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[ //3
          Container(  // discussion information
            child: Column(
              children: <Widget>[ //3
                Container(  // first, overlaying row; Not sure how to implement
                  child: Text(
                    'Diskussionsinformation',
                  ),
                ),
                Container(  //
                  child: Text(
                    'Topic: ' + '${room.topic}',
                  ),
                ),
                Container(
                  child: Text(
                    'Creator: ' , // + creator from data; not listed in models/room.dart; does backend send it? if so, just add and catch value
                  ),
                ),
              ],
            )
          ),

          Container(  // speaker information
            child: Column(
              children: <Widget>[ //2
                Container(  // first, overlaying row; Not sure how to implement
                  child: Text(
                    'Beitragsinformation',
                  ),
                ),
                Container(  // second row
                  child: Row(
                    children: <Widget>[ //2
                      Container(  // column with 2 text fields, speaker and speak time
                        child: Column(
                          children: <Widget>[ //2
                            Container(
                              child: Text(
                                'Speaker: ' , // + speaker name from data; how?
                              ),
                            ),
                            Container(
                              child: Text(
                                'Speak time: ', // need a way to count time; have it appear next to the text and update
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(  //  the question mark symbol
                        // Question Mark -> Doesn't exist as icon; Add manually/own subclass? Or use picture?
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(  // input list
            child: Column(
              children: <Widget>[
                // dynamic amount; how? Builder widget? Update?
                // 1 row per contribution: icon + name for other people, icon + name + icon for user
              ],
            ),
          ),

        ],
      ),

      // button to create contribution
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return ContributionDialog();
              });
          },
        child: Icon(Icons.add),
    ),

    );
  }
}