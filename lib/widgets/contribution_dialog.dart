import 'package:flutter/material.dart';

class ContributionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("New Contribution"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        RaisedButton(
          child: Text("Contribution"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        RaisedButton(
          child: Text("Question"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        RaisedButton(
          child: Text("Answer"),
          onPressed: () {
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