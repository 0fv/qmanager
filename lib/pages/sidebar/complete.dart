import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/questionnaireapi.dart';
import 'package:qmanager/modules/questionnairemodule.dart';
import 'package:qmanager/widget/diolog/alertdiolog.dart';
import 'package:qmanager/widget/diolog/newinstancediolog.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class Complete extends StatelessWidget {
  final List<String> _questionnaireTitle = [
    "id",
    "名称",
    "介绍",
    "创建时间",
    "创建账户",
    "最后修改时间",
    "最后修改人"
  ];
  final QuestionnaireApi questionnaireApi = QuestionnaireApi();

  Future<dynamic> _getListData() async {
    return await questionnaireApi.getQuestionnarie(isEdit: 1);
  }

  DataCell _getOC(BuildContext context, var row, VoidCallback refresh) {
    return DataCell(Row(
      children: <Widget>[
        FlatButton(
          child: Text("预览"),
          onPressed: () async {
            var data = await questionnaireApi.getFinishDataById(row['id']);
            var q = Questionnaire.fromJson(data['data']);
            Navigator.pushNamed(context, "/questionnaireView", arguments: q);
          },
        ),
        FlatButton(
          child: Text("退回编辑"),
          onPressed: () async {
            bool v = await alertDialog("确认退回编辑？", context);
            if (v) {
              try {
                await questionnaireApi.changeEditStatus(row["id"], 0);
                popToast("已回退到编辑", context);
                refresh();
              } on DioError catch (e) {
                popToast(e.message, context);
              }
            }
          },
        ),
        FlatButton(child: Text("新建问卷实例"), onPressed: () async{
          await newInstancedialog(context, row);

        })
      ],
    ));
  }

  List<Widget> _getTopBar(
      List<dynamic> selectedRow, BuildContext context, VoidCallback refresh) {
    return <Widget>[
      opButton(context, "刷新", Icon(Icons.refresh), () {
        refresh();
      }),
    ];
  }

  Map<String, dynamic> _getMap(var m) {
    return Questionnaire.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: MyDataTable(
      _getListData,
      _questionnaireTitle,
      Questionnaire(
          id: "id",
          name: "name",
          introduce: "intrudoce",
          createdTime: DateTime.now(),
          createdAccount: "x",
          editedTime: DateTime.now(),
          editedAccount: "x"),
      "已完成编辑模板",
      _getTopBar,
      _getMap,
      getOperationCell: _getOC,
    ));
  }
}
