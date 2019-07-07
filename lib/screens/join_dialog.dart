import 'package:flutter/material.dart';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/models/user.dart';
import 'package:speechlist/models/value.dart';
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
  String _userPassword = "";
  var selectedCategories = new Map<String, String>();

  _JoinDialogState(this.room);

  @override
  void initState() {
    super.initState();
    room.categories.forEach( (cat) => selectedCategories[cat.name] = cat.values[0].value );
    Preferences().getUserName().then((userName) => textController.text = userName);
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
        margin: EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                    decoration: InputDecoration(
                        labelText: "Your Name"
                    ),
                    controller: textController
                )
            ),
            Container(
              padding: EdgeInsets.only(top: 40, bottom: 40),
              child: Column(
                children: <Widget>[
                  Text(
                    "Choose your properties",
                    style: TextStyle(fontSize: 22),
                  ),

                  Column(
                    children: room.categories.map( (cat) {
                      return Column(children: <Widget>[
                        Padding(padding: EdgeInsets.all(5.0),),
                        Text(cat.name),
                        DropdownButton<String>(
                          value: selectedCategories[cat.name],
                          items: cat.values.map((Value value) {
                            return new DropdownMenuItem<String>(
                              value: value.value,
                              child: new Text(value.value),
                            );
                          }).toList(),
                          onChanged: (selectedItem) => setState( () => selectedCategories[cat.name] = selectedItem ),
                          style: new TextStyle(
                            color: Color(0xFF00206B),
                            fontSize: 20,
                          ),
                        ),
                      ],);
                    } ).toList()
                  ),

                ],),
            ),

            _passwordButton(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                child: Text(
                  "Enter Room",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () async {
                  Preferences().setUserName(textController.text);

                  print(selectedCategories);
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