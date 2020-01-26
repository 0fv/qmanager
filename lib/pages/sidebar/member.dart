import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/membergroupapi.dart';
import 'package:qmanager/modules/membergroupmodule.dart';
import 'package:qmanager/widget/diolog/alertdiolog.dart';
import 'package:qmanager/widget/diolog/membergroupdiolog.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class Member extends StatelessWidget {
  final List<String> _title = ["id", "名称", "创建时间", "创建账户", "最后修改时间", "最后修改人"];
  final MemberGroupApi memberGroupApi = MemberGroupApi();

  Future<dynamic> _getListData() async {
    return await memberGroupApi.getData();
  }

  DataCell _getOC(BuildContext context, var row, VoidCallback refresh) {
    return DataCell(Row(
      children: <Widget>[
        FlatButton(
          child: Text("编辑"),
          onPressed: () async {  
            var mg = MemberGroup(groupName: row["group_name"],id:row["id"]);
            bool v = await memberGroupEditDialog(context,memberGroup:mg);
            if (v == true) {
              refresh();
            }
          },)
      ],
    ));
  }

  List<Widget> _getTopBar(
      List<dynamic> selectedRow, BuildContext context, VoidCallback refresh) {
    return <Widget>[  opButton(
          context,
          "删除",
          Icon(
            Icons.delete,
            color: Colors.red,
          ),
          selectedRow.isEmpty
              ? null
              : () async {
                  bool flag = await alertDialog("确认删除已选择问卷？", context);
                  if (flag) {
                    try {
                      selectedRow.forEach((f) async {
                        String id = f["id"];
                        await memberGroupApi.deleteData(id);
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
      opButton(context, "新建被调查组", Icon(Icons.create), () async {
        var v = await memberGroupEditDialog(context);
        if (v == true) {
          refresh();
        }
      })
    ];
  }

  Map<String, dynamic> _getMap(var m) {
    return MemberGroup.fromJson(m).toMap();
    
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: MyDataTable(
      _getListData,
      _title,
      MemberGroup(
          id: "id",
          groupName: "name",
          createdTime: DateTime.now(),
          createdAccount: "x",
          editedTime: DateTime.now(),
          editedAccount: "x"),
      "成员管理",
      _getTopBar,
      _getMap,
      getOperationCell: _getOC,
    ));
  }
}
