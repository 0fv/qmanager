import 'package:flutter/material.dart';

const String server = "http://127.0.0.1:8000";
const Map<String, String> qname = {
  "id": "_id",
  "名称": "name",
  "介绍": "introduce",
  "创建时间": "created_time",
  "修改时间": "modify_time"
};
typedef DataCell GetOperationCell(BuildContext context, var row);
typedef Future<dynamic> GetListData();
typedef List<Widget> GetTopButton(
    List<dynamic> seletedRow, BuildContext context);
typedef void OpTable(List<dynamic> selectedRow);
typedef List<DataCell> GetDataCells(var row);
typedef void SetValue(String str);
