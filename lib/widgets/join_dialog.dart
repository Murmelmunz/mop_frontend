import 'package:flutter/material.dart';
import 'package:speechlist/models/room.dart';

class JoinDialog extends StatefulWidget {
  static const String routeName = "/search_room";
  final Room room;

  JoinDialog(this.room, {Key key}) : super(key: key);

  @override
  _JoinDialogState createState() => new _JoinDialogState(this.room);
}

class _JoinDialogState extends State<JoinDialog> {
  Room room;
  _JoinDialogState(this.room);

  // Block of declared variables
  List _cities = [
    "Cluj-Napoca",
    "Bucuresti",
    "Timisoara",
    "Brasov",
    "Constanta"
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;

  // Key to initialize the Alert dialog
  final _formKey = GlobalKey<FormState>();

  // to change a old value to a new value of a dropdown button
  void changedDropDownItem(String selectedCity) {
    print("Selected city $selectedCity, we are going to refresh the UI");
    setState(() {
      _currentCity = selectedCity;
    });
  }

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(8.0),
                child: new DropdownButton(
                  value: _currentCity,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                )),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: new DropdownButton(
                value: _currentCity,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Enter Room"),
                onPressed: () {
                  Navigator.of(context)
                      .popAndPushNamed('/room', arguments: room.roomId);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
