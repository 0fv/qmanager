import 'package:flutter/material.dart';
import 'package:qmanager/api/questionnaireapi.dart';
import 'package:qmanager/modules/questionnairemodule.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class Edit extends StatelessWidget {
  final List<String> _questionnaireTitle = [
    "id",
    "名称",
    "介绍",
    "创建时间",
    "修改时间",
  ];
  final Questionnaireapi questionnaireapi = Questionnaireapi();

  Future<dynamic> _getListData() async {
    return await questionnaireapi.getQuestionnariePage();
  }

  DataCell _getOC( BuildContext context,var row,VoidCallback refresh) {
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

  List<Widget> _getTopBar(List<dynamic> selectedRow, BuildContext context,VoidCallback refresh) {
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

    Map<String,dynamic> _getMap(var m){
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
          modifyTime: DateTime.now()),
      "编辑中",
      _getTopBar,
      _getMap,
      getOperationCell: _getOC,
    ));
  }
}
