import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/questioncollectionapi.dart';
import 'package:qmanager/modules/questioncellcollectionmodule.dart';
import 'package:qmanager/modules/questioncellmodule.dart';
import 'package:qmanager/modules/questiongroupcollectionmodule.dart';
import 'package:qmanager/utils/adapterutil.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/table/questiontable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

Future<List<QuestionCell>> questionCellCollectionTable(BuildContext context) =>
    showDialog<List<QuestionCell>>(
        context: context,
        builder: (context) => Container(
              width: 800,
              child: QuestionCellTable(),
            ));

Future<void> questionGroupView(
    BuildContext context, QuestionGroupCollection questionGroupCollection) {
  return showDialog<void>(
      context: context,
      builder: (context) => Container(
          padding: EdgeInsets.fromLTRB(200, 20, 200, 10),
          width: 700,
          height: 1000,
          child: ListView(
            children: questionGroupCollection.questionCells
                .map((f) =>
                    view(context, Adapterutil.getQuestionCellCollection(f),colume: true))
                .toList(),
          )));
}

class QuestionCellTable extends StatelessWidget {
  final List<String> _questionnaireTitle = [
    "id",
    "问题名称",
    "问题类型",
    "创建时间",
    "创建人",
    "最后修改时间",
    "最后修改人"
  ];
  final QuestionCollectionApi questionCollectionApi = QuestionCollectionApi();
  Future<dynamic> _getListData() async {
    return await questionCollectionApi.getData();
  }

  DataCell _getOC(BuildContext context, var row, VoidCallback refresh) {
    return DataCell(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text("查看问题"),
          onPressed: () async {
            var json = await questionCollectionApi.getDataById(row["id"]);

            QuestionCellCollection questionCellCollection =
                QuestionCellCollection.fromJson(json["data"]);
            await viewQuestionCell(context, questionCellCollection);
          },
        ),
      ],
    ));
  }

  List<Widget> _getTopBar(List<dynamic> selectedRow, BuildContext context,
          VoidCallback refresh) =>
      <Widget>[
        opButton(
            context,
            "添加",
            Icon(
              Icons.add,
              color: Colors.blueGrey,
            ),
            selectedRow.isEmpty
                ? null
                : () async {
                    List<QuestionCell> questionCells = [];
                    for (var i in selectedRow) {
                      String id = i["id"];
                      var json = await questionCollectionApi.getDataById(id);
                      QuestionCell questionCell =
                          QuestionCell.fromJson(json["data"]);
                      questionCell.title = i["title"];
                      questionCells.add(questionCell);
                    }
                    Navigator.of(context).pop(questionCells);
                  }),
        opButton(context, "取消", Icon(Icons.cancel), () {
          Navigator.of(context).pop();
        })
      ];
  Map<String, dynamic> _getMap(var m) {
    return QuestionCellCollection.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink(
        child: MyDataTable(
      _getListData,
      _questionnaireTitle,
      QuestionCellCollection(
        id: "id",
        title: "title",
        classification: "class",
        createdAccount: "s",
        editedAccount: "x",
        createdTime: DateTime.now(),
        editedTime: DateTime.now(),
      ),
      "问题管理",
      _getTopBar,
      _getMap,
      getOperationCell: _getOC,
    ));
  }
}

Future<void> viewQuestionCell(
    BuildContext context, QuestionCellCollection questionCellCollection) {
  return showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 600,
            height: 400,
            child: view(context, questionCellCollection),
            decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.softLight,
                color: Color.fromRGBO(0, 0, 0, 100),
                border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 100),
                    width: 0,
                    style: BorderStyle.none)),
          ),
        );
      });
}
