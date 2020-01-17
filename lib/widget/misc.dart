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

Widget input(
    BuildContext context,
    String name,
    ValueChanged<String> vc, {
    int length = 100,
    int line = 1,
    TextInputType tp = TextInputType.text,
    TextEditingController tec,
    FocusNode fn,
  }) =>
      Builder(
        builder: (context) => Container(
          child: TextField(
            focusNode: fn,
            keyboardType: tp,
            minLines: line,
            maxLines: line,
            maxLength: length,
            controller: tec,
            decoration: InputDecoration(
              hintText: name,
            ),
            onChanged: vc,
          ),
        ),
      );