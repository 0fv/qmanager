import 'package:flutter/material.dart';
import 'package:qmanager/api/userapi.dart';
import 'package:qmanager/modules/usermodule.dart';
import 'package:qmanager/widget/mydatatable.dart';
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

  DataCell _getOC( BuildContext context,var row) {
    return DataCell(Row(
      children: <Widget>[
        FlatButton(
          child: Text("编辑"),
          onPressed: () {
            Navigator.pushNamed(context, '/questionnaireEdit',arguments: row);
          },
        )
      ],
    ));
  }

  List<Widget> _getTopBar(List<dynamic> selectedRow, BuildContext context) {
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
              : () {
                  print(selectedRow);
                })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: MyDataTable(
      _getListData,
      _getOC,
      _questionnaireTitle,
      User(
          id: "id",
          username: "name",
          isSuper: "1",
          createdTime: DateTime.now(),
          lastLogin: DateTime.now()),
      "用户管理",
      _getTopBar,
    ));
  }
}