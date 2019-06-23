import 'package:flutter/material.dart';
import 'package:speechlist/models/contribution.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/models/user.dart';
import 'package:speechlist/utils/network.dart';
import 'package:speechlist/utils/preferences.dart';

// ignore: must_be_immutable
class ContributionPage extends StatefulWidget {
  static const String routeName = "/contribute_room";
  List<Contribution> allContributions = [];

  ContributionPage(this.allContributions);

  @override
  _ContributionState createState() => new _ContributionState(this.allContributions);
}

class _ContributionState extends State<ContributionPage> {
  List<Contribution> allContributions = [];

  _ContributionState(this.allContributions);

  void addToList(int value){
    if(value == 1){
      allContributions.add(new Contribution(1207, "lib/assets/rede_icon.png", "Name"));
    } else if (value == 2){
      allContributions.add(new Contribution(0511, "lib/assets/fragezeichen_icon.png", "Name"));
    } else if (value == 3) {
      allContributions.add(
          new Contribution(2411, "lib/assets/antwort_icon.png", "Name"));
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
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

      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 60),
                  child: new Text(
                  "Create a new Contribution",
                  style: new TextStyle(
                    fontSize: 25,
                    color: Color(0xFF00206B),
                  ),
                ),
                ),
              ],
            ),

          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Image.asset(
                    'lib/assets/rede_icon.png',
                    height: 60,
                    width: 60,
                  ),
                ),
                RaisedButton(
                  color: new Color(0xFF00206B),
                  child: Text(
                    "Statement",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      addToList(1);
                    });
                    await Network().createRoomContribution(
                        Room(await Preferences().getCurrentRoomId(), null, null, null, null, null, null),
                        Contribution(null, "Statement", await Preferences().getUserName()),
                        User(await Preferences().getUserId(), await Preferences().getUserName(), null)
                    );
                    Navigator.of(context).pop();
                  },
                ),


                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Image.asset(
                    'lib/assets/fragezeichen_icon.png',
                    height: 60,
                    width: 60,
                  ),
                ),


                RaisedButton(
                  color: new Color(0xFF00206B),
                  child: Text(
                    "Question",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () async {
                    addToList(2);
                    await Network().createRoomContribution(
                      Room(await Preferences().getCurrentRoomId(), null, null, null, null, null, null),
                      Contribution(null, "Question", await Preferences().getUserName()),
                      User(await Preferences().getUserId(), await Preferences().getUserName(), null)
                    );
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Image.asset(
                    'lib/assets/antwort_icon.png',
                    height: 60,
                    width: 60,
                  ),
                ),
                RaisedButton(

                  color: new Color(0xFF00206B),
                  child: Text(
                    "Answer",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () async {
                    addToList(3);
                    await Network().createRoomContribution(
                        Room(await Preferences().getCurrentRoomId(), null, null, null, null, null, null),
                    Contribution(null, "Answer", await Preferences().getUserName()),
                    User(await Preferences().getUserId(), await Preferences().getUserName(), null)
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}