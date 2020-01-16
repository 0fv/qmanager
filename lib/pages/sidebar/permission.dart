import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/userapi.dart';
import 'package:qmanager/modules/usermodule.dart';
import 'package:qmanager/utils/datacellutil.dart';
import 'package:qmanager/widget/diolog/alertdiolog.dart';
import 'package:qmanager/widget/diolog/userdiolog.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class Permission extends StatelessWidget {
  final List<String> _questionnaireTitle = [
    "id",
    "用户名",
    "创建时间",
    "最近一次登陆",
    "是否为管理员",
  ];
  final UserApi userApi = UserApi();

  Future<dynamic> _getListData() async {
    return await userApi.getUserInfo();
  }

  DataCell _getOC(BuildContext context, var row) {
    return DataCell(Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
              child: Text("修改密码"),
              onPressed: () async {
                User user = await updateUserPasswordDialog(context, row["id"]);
                if (user != null) {
                  try {
                    await userApi.updateUser(user);
                    popToast("修改成功", context);
                  } on DioError catch (error) {
                    var msg = error.message;

                    popToast(msg, context);
                  }
                }
              }),
          FlatButton(
              child: Text("修改权限"),
              onPressed: () async {
                var user = await userApi.getUserById(row["id"]);
                print(user);
                User u = User.fromJson(user["data"]);
                User up = await updateUserPermission(context, u);
                if (up != null) {
                  try {
                    await userApi.updateUser(up);
                    popToast("修改成功", context);
                  } on DioError catch (error) {
                    var msg = error.message;

                    popToast(msg, context);
                  }
                }
              }),
        ],
      ),
    ));
  }

  List<Widget> _getTopBar(
      List<dynamic> selectedRow, BuildContext context, VoidCallback refresh) {
    return <Widget>[
      opButton(
          context,
          "删除",
          Icon(
            Icons.delete,
            color: Colors.red,
          ),
          selectedRow.isEmpty
              ? null
              : () async {
                  bool flag = await alertDialog("确认删除已选择帐号？", context);
                  if (flag) {
                    try {
                      selectedRow.forEach((f) async {
                        String id = f["id"];
                        await userApi.deleteUser(id);
                      });
                      popToast("已删除", context);
                      Future.delayed(Duration(seconds: 2)).then((onValue) {
                        refresh();
                      });
                    } on DioError catch (error) {
                      var msg = error.message;
                      popToast(msg, context);
                    }
                  }
                }),
      opButton(context, "新建帐号", Icon(Icons.create), () async {
        User u = await addUserDialog(context);
        if (u != null) {
          try {
            await userApi.addUser(u);
            popToast("创建成功", context);
            Future.delayed(Duration(seconds: 2)).then((onValue) {
              refresh();
            });
          } on DioError catch (error) {
            var msg = error.message;
            popToast(msg, context);
          }
        }
      })
    ];
  }

  DataCell _getDataCell(int index, var value) {
    if (index == 4) {
      return DataCellUtil.getDataCell(value, 200,
          setText: (value) => value == 1 ? Text("是") : Text("否"));
    } else {
      return DataCellUtil.getDataCell(value, 200);
    }
  }

  Map<String, dynamic> _getMap(var m) {
    return User.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: MyDataTable(
      _getListData,
      _questionnaireTitle,
      User(
          id: "id",
          username: "name",
          isSuper: 1,
          createdTime: DateTime.now(),
          lastLogin: DateTime.now()),
      "用户管理",
      _getTopBar,
      _getMap,
      getDataCell: _getDataCell,
      getOperationCell: _getOC,
    ));
  }
}
