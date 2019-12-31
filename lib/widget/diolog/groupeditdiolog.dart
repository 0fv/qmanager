import 'package:flutter/material.dart';

Future<String> questionGroupEditDialog(BuildContext context, String gname) {
  TextEditingController tec = new TextEditingController();
  tec.text = gname;
  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("修改"),
        content: input("问题组名", tec),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(), // 关闭对话框
          ),
          FlatButton(
            child: Text("确定"),
            onPressed: () {
              //关闭对话框并返回true
              Navigator.of(context).pop(tec.text);
            },
          ),
        ],
      );
    },
  );
}

Future<bool> questionGroupDeleteDialog(BuildContext context) {
 
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("修改"),
        content: Text("确定删除？"),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(), // 关闭对话框
          ),
          FlatButton(
            child: Text("确定"),
            onPressed: () {
              //关闭对话框并返回true
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}

Widget input(String name, TextEditingController tec,
    {int maxLines = 1, int maxLength}) {
  return Container(
    child: TextField(
      minLines: 1,
      controller: tec,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: name,
        border: InputBorder.none,
      ),
    ),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.black12, width: 2)),
  );
}
