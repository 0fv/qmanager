import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

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

Toast popToast(String msg, BuildContext context) {
  Toast.show("$msg", context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}
