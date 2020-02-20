import 'package:flutter/material.dart';
import 'package:qmanager/api/mailapi.dart';
import 'package:qmanager/modules/maillogmodule.dart';
import 'package:qmanager/utils/datacellutil.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class MailLogPage extends StatelessWidget {
  final List<String> title = [
    "日志id",
    "问卷实体id",
    "问卷标题",
    "被调查人",
    "email",
    "状态",
    "信息",
    "发送时间"
  ];
  final MailApi mailApi = MailApi();
  Future<dynamic> _getListData() async {
    return await mailApi.getMailLog();
  }

  List<Widget> _getTopBar(
      List<dynamic> selectedRow, BuildContext context, VoidCallback refresh) {
    return <Widget>[
      opButton(context, "刷新", Icon(Icons.refresh), () {
        refresh();
      }),
    ];
  }

  DataCell _getDataCell(int index, var value) {
    if (index == 5) {
      return DataCellUtil.getDataCell(
        value,
        200,
        setText: (value) => value == 1
            ? Text(
                "成功",
                style: TextStyle(color: Colors.green),
              )
            : Text("失败", style: TextStyle(color: Colors.red)),
      );
    } else {
      return DataCellUtil.getDataCell(value, 200);
    }
  }

  Map<String, dynamic> _getMap(var m) {
    return MailLog.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: MyDataTable(
      _getListData,
      title,
      MailLog(
          id: "id",
          title: "name",
          name: "",
          sendTime: DateTime.now(),
          email: "DateTime.now()",
          status: false,
          questionnaireEntityId: "",
          message: ""),
      "邮件发送日志",
      _getTopBar,
      _getMap,
      getDataCell: _getDataCell,
    ));
  }
}
