import 'package:flutter/material.dart';

class SearchRoomPage extends StatefulWidget {
    static const String routeName = "/search_room";
    SearchRoomPage({Key key, this.title}) : super(key: key);
    final String title;

      @override
      _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<SearchRoomPage> {
  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "$i");
  var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);

    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();

      dummySearchList.forEach((item) {
        if(item.contains(query)) {
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
        title: new Text('SpeechList',
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
                        borderRadius: BorderRadius.all(Radius.circular(25.0))
                    ),
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
                    padding: EdgeInsets.only(left:10, right:10, top:5, bottom:5),
                      alignment: Alignment(0, 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(width: 0.2),
                        ),
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
                                    'Topic: ' + '${items[index]}',
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
                                    'ID: ' + '${items[index]}',
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
                                    'Meeting point: ' + '${items[index]}',
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
                                        Navigator.of(context).pushNamed('/search_room');
                                      },
                                    ),
                                    ),
                              ]
                          )
                        )
                      ),
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