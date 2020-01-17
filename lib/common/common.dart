import 'package:flutter/material.dart';
import 'package:qmanager/modules/answercellmodule.dart';

const String server = "http://127.0.0.1:8000";
const Map<String, String> qname = {
  "id": "_id",
  "名称": "name",
  "介绍": "introduce",
  "创建时间": "created_time",
  "修改时间": "modify_time"
};
typedef DataCell GetOperationCell(BuildContext context, var row,VoidCallback refresh);
typedef Future<dynamic> GetListData();
typedef List<Widget> GetTopButton(
    List<dynamic> seletedRow, BuildContext context,VoidCallback refresh);
typedef void OpTable(List<dynamic> selectedRow);
typedef List<DataCell> GetDataCells(var row);
typedef void SetValue(String str);
typedef void SetAnswerCell(AnswerCell answerCell);
typedef DataCell GetDataCell(int index,var value);
typedef Text SetText(var value);
typedef Map<String,dynamic> GetType(var m);
