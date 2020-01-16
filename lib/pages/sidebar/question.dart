import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/questioncollectionapi.dart';
import 'package:qmanager/modules/questioncellcollectionmodule.dart';
import 'package:qmanager/widget/diolog/questioncellcollection.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class Question extends StatelessWidget {
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

  DataCell _getOC(BuildContext context, var row) {
    return DataCell(Text("Edit"));
  }

  List<Widget> _getTopBar(List<dynamic> selectedRow, BuildContext context,
          VoidCallback refresh) =>
      <Widget>[
        opButton(context, "新建调查问题", Icon(Icons.create), () async {
          QuestionCellCollection q = await addQuestionDialog(context);
          if (q != null) {
            try {
              await questionCollectionApi.addData(q);
              popToast("创建成功", context);
              Future.delayed(Duration(seconds: 2)).then((onValue) {
                refresh();
              });
            } on DioError catch (error) {
              var msg = error.message;
              popToast(msg, context);
            }
          }
        })
        // if (q != null) {
        //   try {
        //     await userApi.addUser(u);
        //     popToast("创建成功", context);
        //     Future.delayed(Duration(seconds: 2)).then((onValue) {
        //       refresh();
        //     });
        //   } on DioError catch (error)  {
        //     var msg = error.message;
        //     popToast(msg, context);
        //   }
        // }
      ];
  Map<String, dynamic> _getMap(var m) {
    return QuestionCellCollection.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
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
