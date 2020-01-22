import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/questiongroupcollectionapi.dart';
import 'package:qmanager/modules/questiongroupcollectionmodule.dart';
import 'package:qmanager/widget/diolog/alertdiolog.dart';
import 'package:qmanager/widget/diolog/questiongroupcollectiontablediolog.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class QuestionGroup extends StatelessWidget {
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
          child: Text("编辑"),
          onPressed: () async {
            var r = await questionGroupCollectionApi.getDataById(row["id"]);
            QuestionGroupCollection q =
                QuestionGroupCollection.fromJson(r["data"]);
            var v = await Navigator.pushNamed(context, "/questionGroupEdit",
                arguments: q);
            if (v == true) {
              refresh();
            }
          },
        ),
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
        opButton(context, "新建问题组", Icon(Icons.create), () async {
          var v = await Navigator.pushNamed(context, "/questionGroupEdit");
          if (v == true) {
            refresh();
          }
        }),
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
                    bool flag = await alertDialog("确认删除已选择问题组？", context);
                    if (flag) {
                      try {
                        selectedRow.forEach((f) async {
                          String id = f["id"];
                          await questionGroupCollectionApi.deleteUser(id);
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
      ];
  Map<String, dynamic> _getMap(var m) {
    return QuestionGroupCollection.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
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
      "问题组管理",
      _getTopBar,
      _getMap,
      getOperationCell: _getOC,
    ));
  }
}
