import 'package:flutter/material.dart';

class CategoryValuesDialog extends StatefulWidget {
  @override
  _CategoryValuesDialogState createState() => _CategoryValuesDialogState();
}

class _CategoryValuesDialogState extends State<CategoryValuesDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Category Values"),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(List<String>()..add("testB"));
              },
            )
          ]
      ),
    );
  }
}