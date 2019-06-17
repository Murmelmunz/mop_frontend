import 'package:flutter/material.dart';

class CategoryValuesDialog extends StatefulWidget {
  @override
  _CategoryValuesDialogState createState() => _CategoryValuesDialogState();
}

class _CategoryValuesDialogState extends State<CategoryValuesDialog> {
  var textControllerList = List<TextEditingController>();
  var textControllerForNewItem = TextEditingController();
  var values = List<String>();

  void _removeValue(int index) {
    setState(() {
      values.removeAt(index);
      textControllerList.removeAt(index);
    });
  }

  void _addValue() {
    setState(() {
      textControllerList.add(TextEditingController(text: "${textControllerForNewItem.text}"));
      values.add("${textControllerForNewItem.text}");
      textControllerForNewItem.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Category Values"),
      content: Container(
        height: 900,
        width: 600,
        child: ListView.builder(
          itemCount: values.length + 1,
          itemBuilder: (context, index) {
            bool last = values.length + 1 == (index + 1);

            if (!last) {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (text) => values[index] = text,
                  controller: textControllerList[index],
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => _removeValue(index)
                      )),
                ),
              );

            } else {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: textControllerForNewItem,
                      decoration: InputDecoration(
                          hintText: "New Value",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => _addValue()
                          )),
                    ),

                    RaisedButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop(values);
                      },
                    ),

                  ],
                ),
              );

            }

          }

        ),
      ),
    );
  }
}