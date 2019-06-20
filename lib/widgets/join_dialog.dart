import 'package:flutter/material.dart';
import 'package:speechlist/models/room.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speechlist/utils/preferences.dart';

class JoinDialog extends StatefulWidget {
  static const String routeName = "/search_room";
  final Room room;

  JoinDialog(this.room, {Key key}) : super(key: key);

  @override
  _JoinDialogState createState() => new _JoinDialogState(this.room);
}

class _JoinDialogState extends State<JoinDialog> {
  Room room;
  var textController = new TextEditingController();
  SharedPreferences sharedPreferences;

  _JoinDialogState(this.room);

  // Block of declared variables
  List _cities = [
    "Blond",
    "Braun",
    "Grau",
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
//    _cities.add(room.categories[0].name);
//    _cities.add(room.categories[0].values[0].value);

    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    Preferences().getUserName().then((userName) => textController.text = userName);

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
                child: TextField(

                    decoration: InputDecoration(
                        labelText: "Your Name",
                        fillColor: Color(0xFF00206B)
                    ),
                    controller: textController
                )
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: new DropdownButton(
                  value: _currentCity,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: new Color(0xFF00206B),
                child: Text(
                  "Enter Room",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Preferences().setUserName(textController.text);
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
