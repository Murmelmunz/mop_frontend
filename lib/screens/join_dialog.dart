import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/models/user.dart';
import 'package:speechlist/utils/network.dart';
import 'package:speechlist/utils/preferences.dart';

class JoinDialogPage extends StatefulWidget {
  static const String routeName = "/join_room";
  Room room;

  JoinDialogPage({Key key, this.room}) : super (key: key);

  @override
  _JoinDialogState createState() => new _JoinDialogState(this.room);
}

class _JoinDialogState extends State<JoinDialogPage>{
  Room room;
  var textController = new TextEditingController();
  SharedPreferences sharedPreferences;
  String _userPassword = "";


  //Try
  List<DropdownMenuItem<String>> _allCategories;
  List<List<String>> _CategoriesInCategory =
  [
    [
      "Blond",
      "Braun",
    ],
    [
      "Ledig",
      "Verlobt",
      "Verheiratet",
    ],
    [
      "Links",
      "Rechts",
    ],
  ];
  String _currentCategory;
  List _categorynames = [
    "Haarfarbe",
    "Familienstand",
    "Schreibhand",
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCity;
  // Block of declared variables
  List _cities = [
    "Blond",
    "Braun",
    "Grau",
  ];

  _JoinDialogState(this.room);


  void changeCategory(String selectedCategory){
    setState(() {
      _currentCategory = selectedCategory;
    });
  }

  List<DropdownMenuItem<String>> _fillCategories(int index){
    List<DropdownMenuItem<String>> items = new List();
    for(List _list in _CategoriesInCategory) {
      for (String item in _list) {
        items.add(new DropdownMenuItem(value: item, child: new Text(item)));
      }
      return items;
    }
  }

  Widget _createDropDown(BuildContext context, int index){
    return Container(
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: new DropdownButton(
            value: _currentCategory,
            items: _fillCategories(index),
            onChanged: changeCategory,
          )),
    );
  }

  // To hide or show the password button
  Widget _passwordButton(){
    if(this.room.password != "lib/assets/schloss_icon_offen.png"){
      return TextField(
        decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(Icons.vpn_key),
            suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {},
            )
        ),
        onChanged: (text) {
          _userPassword = text;
        },
      );
    } else{
      return new Container();
    }
  }


  // DEMO
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
    Preferences().getUserName().then((userName) =>
    textController.text = userName);
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

      body:  Container(
        margin: EdgeInsets.all(10),
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
            Container(
              padding: EdgeInsets.only(top: 40, bottom: 40),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Choose your properties",
                              style: new TextStyle(
                                fontSize: 22,
                                color: Color(0xFF00206B),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: new ButtonTheme(
                                      alignedDropdown: true,
                                      child: new DropdownButton(
                                        value: _currentCity,
                                        items: _dropDownMenuItems,
                                        onChanged: changedDropDownItem,
                                        style: new TextStyle(
                                          color: Color(0xFF00206B),
                                          fontSize: 20,
                                        ),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],),

                    ],
                  ),
                ],),
            ),

            _passwordButton(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                color: new Color(0xFF00206B),
                child: Text(
                  "Enter Room",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onPressed: () async {
                  Preferences().setUserName(textController.text);

                  User user = await Network().joinRoom(room.roomId, User(null, await Preferences().getUserName(), _userPassword));
                  Preferences().setUserId(user.id);
                  Preferences().setCurrentRoomId(room.roomId);

                  Navigator.of(context)
                      .pushNamed('/room', arguments: room.roomId);
                },
              ),
            ),




          ],
        ),
      ),
      
    );
  }
}