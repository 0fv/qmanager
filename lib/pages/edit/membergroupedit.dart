import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/memberapi.dart';
import 'package:qmanager/modules/membermodule.dart';
import 'package:qmanager/widget/diolog/alertdiolog.dart';
import 'package:qmanager/widget/diolog/memberdiolog.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class MemeberGroupEdit extends StatelessWidget {
  final argumemt;
  MemberApi _memberApi;
  MemeberGroupEdit({Key key, this.argumemt}) {
    this._memberApi = MemberApi(argumemt);
  }

  final List<String> _title = ["id", "姓名", "邮箱号", "附加信息"];
  Future<dynamic> _getListData() async {
    return await _memberApi.getData();
  }

  DataCell _getOC(BuildContext context, var row, VoidCallback refresh) {
    return DataCell(Row(
      children: <Widget>[
        FlatButton(
          child: Text("编辑"),
          onPressed: () async {
            bool v = await memberEditdialog(context, argumemt,
                member: Member.fromJson(row));
            if (v) {
              refresh();
            }
          },
        ),
      ],
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
                  bool flag = await alertDialog("确认删除已选择人员？", context);
                  if (flag) {
                    try {
                      selectedRow.forEach((f) async {
                        String id = f["id"];
                        await _memberApi.deleteData(id);
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
      opButton(context, "刷新", Icon(Icons.refresh), () {
        refresh();
      }),
      opButton(context, "新建成员", Icon(Icons.create), () async {
        bool v = await memberEditdialog(context, argumemt);
        if (v) {
          refresh();
        }
      }),
      opButton(context, "下载导入模板", Icon(Icons.arrow_downward), () {
        this._memberApi.template();
      }),
      opButton(context, "导入", Icon(Icons.file_upload), () async {
        this._memberApi.uploadData(this.argumemt, refresh, context);
      }),
      opButton(context, "导出", Icon(Icons.file_download), () {
        this._memberApi.export(argumemt);
      })
    ];
  }

  Map<String, dynamic> _getMap(var m) {
    return Member.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("成员管理"),
        ),
        body: SizedBox.expand(
          child: MyDataTable(
            _getListData,
            _title,
            Member(
              id: "id",
              name: "name",
              email: "email",
              additionalInfo: "if",
            ),
            "成员管理",
            _getTopBar,
            _getMap,
            getOperationCell: _getOC,
          ),
        ));
  }
}
