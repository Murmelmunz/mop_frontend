import 'package:flutter/material.dart';
import 'package:speechlist/models/contribution.dart';

class ContributionDialog extends StatelessWidget {
  List<Contribution> _allContributions = [];

  ContributionDialog(List<Contribution> list) {
    this._allContributions = list;
  }

  void addToList(int value){
     if(value == 1){
        _allContributions.add(new Contribution(20, "lib/assets/rede_icon.png", 111));
     } else if (value == 2){
       _allContributions.add(new Contribution(20, "lib/assets/fragezeichen_icon.png", 111));
     } else if (value == 3){
       _allContributions.add(new Contribution(20, "lib/assets/antwort_icon.png", 111));
     }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
          "Create Contribution",
          style: TextStyle(
            color: Color(0xFF00206B),
          ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Image.asset(
                'lib/assets/rede_icon.png',
                height: 40,
                width: 40,
              ),
            ),
            RaisedButton(
              color: new Color(0xFF00206B),
              child: Text(
                "Statement",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                addToList(1);
                Navigator.of(context).pop();
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Image.asset(
                'lib/assets/fragezeichen_icon.png',
                height: 40,
                width: 40,
              ),
            ),


            RaisedButton(
              color: new Color(0xFF00206B),
              child: Text(
                "Question",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                addToList(2);
                Navigator.of(context).pop();
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Image.asset(
                'lib/assets/antwort_icon.png',
                height: 40,
                width: 40,
              ),
            ),
            RaisedButton(

              color: new Color(0xFF00206B),
              child: Text(
                  "Answer",
                  style: TextStyle(
                     color: Colors.white,
                  ),
              ),
              onPressed: () {
                addToList(3);
                Navigator.of(context).pop();
              },
            ),
      ],),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}