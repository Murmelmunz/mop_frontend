import 'package:flutter/material.dart';

class BoxWithTitle extends StatelessWidget {
  final Widget child;
  final String title;

  BoxWithTitle({Key key, this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all()),
            child: child,
          ),
        ),

        Positioned(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("$title"),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          top: 8,
        ),
      ],
    );
  }
}