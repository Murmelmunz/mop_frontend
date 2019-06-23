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
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<List<DropdownMenuItem<String>>> _allCategories;
  String _currentCity;
  String _userPassword = "";
  // Block of declared variables
  List _cities = [
    "Blond",
    "Braun",
    "Grau",
  ];

  _JoinDialogState(this.room);


  //REAL TRY
  List<DropdownMenuItem<String>> getAllCategories(){
    List<DropdownMenuItem<String>> items = new List();
    for(List Category in _allCategories){

    }
    return items;
  }

  void changeCategory(String selectedCategory){
    setState(() {

    });
  }

  Widget _createDropDown(BuildContext context, int index){
    return Container(
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: new DropdownButton(
            value: _allCategories[index][0].toString(),
            items: _allCategories[index],
            onChanged: changedDropDownItem,
          )),
    );
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

      body: Container(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                          Column(children: <Widget>[
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
                                child: Padding(
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
                                )
                            )
                          ],),

                        ],


                    ),

                  ],),

              ),
              Expanded(
                child:new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      TextField(
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
                      ),
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
                      )
                    ],),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}