import 'package:flutter/material.dart';

Widget opButton(
    BuildContext context, String name, Icon icon, VoidCallback func) {
  return Builder(
    builder: (context) {
      return FlatButton(
        child: Row(
          children: <Widget>[icon, Text(name)],
        ),
        onPressed: func,
      );
    },
  );
}
