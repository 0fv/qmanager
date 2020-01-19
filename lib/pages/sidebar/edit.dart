import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/questionnaireapi.dart';
import 'package:qmanager/modules/questionnairemodule.dart';
import 'package:qmanager/widget/diolog/alertdiolog.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class Edit extends StatelessWidget {
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
    return await questionnaireApi.getQuestionnarie(isEdit: 0);
  }

  DataCell _getOC(BuildContext context, var row, VoidCallback refresh) {
    return DataCell(Row(
      children: <Widget>[
        FlatButton(
          child: Text("编辑"),
          onPressed: () async {
            var r = await questionnaireApi.getDataById(row["id"]);
            Questionnaire q = Questionnaire.fromJson(r["data"]);
            Navigator.pushNamed(context, '/questionnaireEdit', arguments: q);
          },
        )
      ],
    ));
  }

  List<Widget> _getTopBar(
      List<dynamic> selectedRow, BuildContext context, VoidCallback refresh) {
    return <Widget>[
      opButton(context, "刷新", Icon(Icons.refresh), () {
        refresh();
      }),
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
                  bool flag = await alertDialog("确认删除已选择问卷？", context);
                  if (flag) {
                    try {
                      selectedRow.forEach((f) async {
                        String id = f["id"];
                        await questionnaireApi.deleteData(id);
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
      opButton(context, "新建问卷表", Icon(Icons.create), () {
        Navigator.pushNamed(context, "/questionnaireEdit");
      })
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
      "编辑中",
      _getTopBar,
      _getMap,
      getOperationCell: _getOC,
    ));
  }
}
