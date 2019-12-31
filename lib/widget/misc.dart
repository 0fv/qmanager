import 'package:flutter/material.dart';

Widget loadingWidget(BuildContext context) {
  return Builder(
    builder: (context) => Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        )
      ],
    ),
  );
}
