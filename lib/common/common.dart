import 'package:flutter/material.dart';
import 'package:qmanager/modules/answercellmodule.dart';
import 'dart:html' as html;

var server = html.window.location.href.replaceAll("/#/", "");
typedef DataCell GetOperationCell(
    BuildContext context, var row, VoidCallback refresh);
typedef Future<dynamic> GetListData();
typedef List<Widget> GetTopButton(
    List<dynamic> seletedRow, BuildContext context, VoidCallback refresh);
typedef void OpTable(List<dynamic> selectedRow);
typedef List<DataCell> GetDataCells(var row);
typedef void SetValue(String str);
typedef void SetAnswerCell(AnswerCell answerCell);
typedef DataCell GetDataCell(int index, var value);
typedef Text SetText(var value);
typedef Map<String, dynamic> GetType(var m);
