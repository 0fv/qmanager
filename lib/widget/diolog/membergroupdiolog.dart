import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/membergroupapi.dart';
import 'package:qmanager/modules/membergroupmodule.dart';
import 'package:qmanager/widget/misc.dart' as Misc;

Future<bool> memberGroupEditDialog(BuildContext context,
    {MemberGroup memberGroup}) {
  TextEditingController tec = new TextEditingController();
  MemberGroupApi memberGroupApi = MemberGroupApi();
  if (memberGroup != null) {
    tec.text = memberGroup.groupName;
  }
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: memberGroup == null ? Text("新建") : Text("修改"),
        content: Misc.input(context, "被调查组名", null, tec: tec),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text("确定"),
            onPressed: () async {
              if (memberGroup == null) {
                MemberGroup mg = MemberGroup(groupName: tec.text);
                try {
                  await memberGroupApi.addData(mg);
                  Navigator.of(context).pop(true);
                  Misc.popToast("添加成功", context);
                } on DioError catch (e) {
                  var msg = e.message;
                  Misc.popToast(msg, context);
                }
              } else {
                memberGroup.groupName = tec.text;
                try {
                  await memberGroupApi.updateData(memberGroup);
                  Navigator.of(context).pop(true);
                  Misc.popToast("修改成功", context);
                } on DioError catch (e) {
                  var msg = e.message;
                  Misc.popToast(msg, context);
                }
              }
            },
          ),
        ],
      );
    },
  );
}
