import 'package:flutter/material.dart';
import 'package:qmanager/api/questiongroupcollectionapi.dart';
import 'package:qmanager/modules/questiongroupcollectionmodule.dart';
import 'package:qmanager/modules/questiongroupmodule.dart';
import 'package:qmanager/utils/adapterutil.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/table/questiontable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

Future<List<QuestionGroup>> questionGroupCollectionTable(
        BuildContext context) =>
    showDialog<List<QuestionGroup>>(
        context: context,
        builder: (context) => Container(
              width: 800,
              child: QuestionGroupTable(),
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
                .map((f) => view(
                    context, Adapterutil.getQuestionCellCollection(f),
                    colume: true))
                .toList(),
          )));
}

class QuestionGroupTable extends StatelessWidget {
  final List<String> _title = [
    "id",
    "问题名称",
    "问题类型",
    "创建时间",
    "创建人",
    "最后修改时间",
    "最后修改人"
  ];
  final QuestionGroupCollectionApi questionGroupCollectionApi =
      QuestionGroupCollectionApi();

  Future<dynamic> _getListData() async {
    return await questionGroupCollectionApi.getData();
  }

  DataCell _getOC(BuildContext context, var row, VoidCallback refresh) {
    return DataCell(Row(
      children: <Widget>[
        FlatButton(
          child: Text("预览问题组内容"),
          onPressed: () async {
            var r = await questionGroupCollectionApi.getDataById(row["id"]);
            QuestionGroupCollection q =
                QuestionGroupCollection.fromJson(r["data"]);
            await questionGroupView(context, q);
          },
        )
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
                    List<QuestionGroup> questionCells = [];
                    for (var i in selectedRow) {
                      String id = i["id"];
                      var json =
                          await questionGroupCollectionApi.getDataById(id);
                      QuestionGroup questionCell =
                          QuestionGroup.fromJson(json["data"]);
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
    return QuestionGroupCollection.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(100, 10, 100, 100),
        child: MyDataTable(
          _getListData,
          _title,
          QuestionGroupCollection(
            id: "id",
            title: "title",
            classification: "class",
            createdAccount: "s",
            editedAccount: "x",
            createdTime: DateTime.now(),
            editedTime: DateTime.now(),
          ),
          "问题组选择",
          _getTopBar,
          _getMap,
          getOperationCell: _getOC,
        ));
  }
}
