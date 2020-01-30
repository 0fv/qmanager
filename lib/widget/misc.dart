import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

popToast(String msg, BuildContext context) {
  Toast.show("$msg", context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}
popToastTest(String msg, BuildContext context) {
  Toast.show("$msg", context,
      duration: 20, gravity: Toast.BOTTOM);
}

Widget input3(BuildContext context, int line, int lenght) => Builder(
    builder: (context) => Container(
      margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
        child: TextField(
          minLines: line,
          maxLines: line,
          maxLength: lenght,
          decoration: InputDecoration(border: InputBorder.none),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 1.0))));

Widget input(BuildContext context, String name, ValueChanged<String> vc,
        {int length = 100,
        int line = 1,
        TextInputType tp = TextInputType.text,
        TextEditingController tec,
        FocusNode fn,
        String lableText}) =>
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
            labelText: lableText,
            hintText: name,
          ),
          onChanged: vc,
        ),
      ),
    );
Widget input2(BuildContext context, String lableText, TextEditingController tec,
        {TextInputType tp = TextInputType.text,
        bool obscureText = false,
        List<TextInputFormatter> wl}) =>
    Builder(
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        width: 700,
        child: TextField(
          keyboardType: tp,
          controller: tec,
          decoration: InputDecoration(
            labelText: lableText,
          ),
          obscureText: obscureText,
          inputFormatters: wl,
        ),
      ),
    );
