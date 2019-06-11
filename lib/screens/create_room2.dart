import 'package:flutter/material.dart';
import 'package:speechlist/main.dart';
import 'package:speechlist/models/room.dart';

class CreateRoomPage2 extends StatefulWidget {
  static const String routeName = "/create_room2";
  final Room room;

  CreateRoomPage2({Key key, this.room}) : super(key: key);

  @override
  _CreateRoomPageState2 createState() => _CreateRoomPageState2(this.room);
}

class _CreateRoomPageState2 extends State<CreateRoomPage2> {
  bool _isLoading = false;
  Room room;
  List<TextEditingController> textControllerList;
  var textControllerForNewItem = TextEditingController();

  _CreateRoomPageState2(this.room);

  @override
  void initState() {
    super.initState();

    // create for each existing category a text controller
    textControllerList = List<TextEditingController>.generate(
      room.categories.length,
      (i) => TextEditingController(text: room.categories[i][0])
    );
  }

  void _removeCategory(int index) {
    setState(() {
      room.categories.removeAt(index);
      textControllerList.removeAt(index);
    });
  }

  void _addCategory() {
    setState(() {
      textControllerList.add(TextEditingController(text: "${textControllerForNewItem.text}"));
      room.categories.add(List()..add("${textControllerForNewItem.text}"));
      textControllerForNewItem.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create Room"),),

        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: <Widget>[
            Container(
              color: MyApp.primaryColorLight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_left),
                    onPressed: () => Navigator.of(context).pushReplacementNamed(
                        "/create_room",
                        arguments: this.room
                    ),
                    color: Colors.white,
                  ),

                  Text("Categorie Selection", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),

                  IconButton(icon: Icon(Icons.arrow_right),
                    onPressed: () => Navigator.of(context).pushReplacementNamed(
                        "/create_room3",
                        arguments: this.room
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                // plus 1 to always show input for adding new categories
                itemCount: room.categories.length + 1,
                itemBuilder: (context, index) {
                  bool last = room.categories.length + 1 == (index + 1);

                  if (!last) {

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (text) => room.categories[index][0] = text,
                        controller: textControllerList[index],
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () => _removeCategory(index)
                            )),
                      ),
                    );

                  } else {

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: textControllerForNewItem,
                        decoration: InputDecoration(
                            hintText: "New Category",
                            suffixIcon: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => _addCategory()
                            )),
                      ),
                    );

                  }
                }
              ),
            ),

          ],
        )

    );
  }
}