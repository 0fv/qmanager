import 'package:flutter/material.dart';
import 'package:qmanager/api/questionnaireapi.dart';
import 'package:qmanager/modules/questionnairemodule.dart';
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
      children: <Widget>[Text("?")],
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
