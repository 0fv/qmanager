import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/mailapi.dart';
import 'package:qmanager/modules/mailschedulemodule.dart';
import 'package:qmanager/utils/datacellutil.dart';
import 'package:qmanager/widget/diolog/alertdiolog.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class MailSchedulePage extends StatelessWidget {
  final List<String> title = ["id", "问卷实体id", "问卷标题", "被调查用户组", "发送时间"];
  final MailApi mailApi = MailApi();
  Future<dynamic> _getListData() async {
    return await mailApi.getMailSchedule();
  }

  List<Widget> _getTopBar(
      List<dynamic> selectedRow, BuildContext context, VoidCallback refresh) {
    return <Widget>[
      opButton(context, "刷新", Icon(Icons.refresh), () {
        refresh();
      }),
    ];
  }

  DataCell _getOC(BuildContext context, var row, VoidCallback refresh) {
    return DataCell(Row(
      children: <Widget>[
        FlatButton(
          child: Text("立即发送"),
          onPressed: () async {
            bool v = await alertDialog("确定立即发送？", context);
            if(v){
              String id = row["id"];
              try{
                await mailApi.sendMailNow(id);
                popToast("操作成功", context);
                refresh();
              }on DioError catch(e){
                popToast(e.message, context);
              }
            }
          },
        )
      ],
    ));
  }

  DataCell _getDataCell(int index, var value) {
    if (index == 3) {
      return DataCellUtil.getDataCell(value, 200, setText: (value) {
        String l = "";
        for (var i = 0; i < value.length; i++) {
          l += (value[i]+",");
        }
        return Text(l);
      });
    } else {
      return DataCellUtil.getDataCell(value, 200);
    }
  }

  Map<String, dynamic> _getMap(var m) {
    return MailSchedule.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: MyDataTable(
      _getListData,
      title,
      MailSchedule(
        id: "id",
        questionnaireTitle: "name",
        memberGroupName: [],
        sendingTime: DateTime.now(),
        questionnaireEntityId: "DateTime.now()",
      ),
      "邮件发送日程",
      _getTopBar,
      _getMap,
      getDataCell: _getDataCell,
      getOperationCell: _getOC
    ));
  }
}
