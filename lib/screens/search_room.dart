import 'package:flutter/material.dart';
import 'package:speechlist/models/room.dart';

// Start of search room with identification
class SearchRoomPage extends StatefulWidget {
  static const String routeName = "/search_room";

  SearchRoomPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

// Start of creating the Screen. You find methods which are needed for the implementation. First of all
// all variables will be declared. Then you find the help methods. At the end there are the flutter return widgets
class _MyHomePageState extends State<SearchRoomPage> {
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
  TextEditingController editingController = TextEditingController();
  final duplicateItems = List<Room>();
  var items = List<Room>();

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
    duplicateItems.add(new Room(234632, "Operation Research", "test2"));
    duplicateItems.add(new Room(1234, "Mobile Programming", "test3434"));
    duplicateItems.add(new Room(234564, "Secure Engineering", "test3434"));
    items.addAll(duplicateItems);
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

  void filterSearchResults(String query) {
    List<Room> dummySearchList = List<Room>();
    dummySearchList.addAll(duplicateItems);

    if (query.isNotEmpty) {
      List<Room> dummyListData = List<Room>();

      dummySearchList.forEach((item) {
        if (item.topic.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });

      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });

      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'SpeechList',
          style: new TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          new IconButton(
            icon: new Image.asset('lib/assets/logo_projekt.png'),
            tooltip: 'Home',
            onPressed: () {
              Navigator.of(context).pushNamed('/search_room');
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  labelStyle: TextStyle(
                    color: const Color(0xFF00206B),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return new Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    alignment: Alignment(0, 0),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(width: 0.2),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                              textDirection: TextDirection.rtl,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  alignment: Alignment(-0.93, 0),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Topic: ' + '${items[index].topic}',
                                    style: TextStyle(
                                      color: const Color(0xFF00206B),
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment(-0.93, 0),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'ID: ' + '${items[index].roomId}',
                                    style: TextStyle(
                                      color: const Color(0xFF00206B),
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment(-0.91, 0),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Meeting point: ' + '${items[index].meetingPoint}',
                                    style: TextStyle(
                                      color: const Color(0xFF00206B),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment(-0.91, 0),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Person count: ' + '${items[index]}',
                                    style: TextStyle(
                                      color: const Color(0xFF00206B),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment(1, 0),
                                  child: new IconButton(
                                    icon: new Icon(Icons.arrow_drop_down),
                                    tooltip: 'Expand for more Information',
                                    iconSize: 30,
                                    color: const Color(0xFF00206B),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child:
                                                            new DropdownButton(
                                                          value: _currentCity,
                                                          items:
                                                              _dropDownMenuItems,
                                                          onChanged:
                                                              changedDropDownItem,
                                                        )),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: new DropdownButton(
                                                        value: _currentCity,
                                                        items:
                                                            _dropDownMenuItems,
                                                        onChanged:
                                                            changedDropDownItem,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: RaisedButton(
                                                        child:
                                                            Text("Enter Room"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  "/search_room");
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ]),
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/create_room', arguments: 456);
        },
        backgroundColor: const Color(0xFF00206B),
        child: Icon(Icons.add),
      ),
    );
  }
}
