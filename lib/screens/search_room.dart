import 'package:flutter/material.dart';

class SearchRoomPage extends StatefulWidget {
    SearchRoomPage({Key key, this.title}) : super(key: key);
    final String title;

      @override
      _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<SearchRoomPage> {
  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Roomname $i");
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
        title: new Text(widget.title),
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
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return new Container(
                    padding: EdgeInsets.only(left:10, right:10, top:5, bottom:5),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text('${items[index]}'),
                            ),
                            ButtonTheme.bar( // make buttons use the appropriate styles for cards
                              child: ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                    child: const Text('Join Room'),
                                    onPressed: () { /* ... */ },
                                  ),
                                ],
                              ),
                            ),
                          ]
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
        child: Icon(Icons.add),
      ),
    );
  }
}