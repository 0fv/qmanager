import 'package:flutter/material.dart';
import 'package:qmanager/common/common.dart';

class DataCellUtil {
  static DataCell getDataCell(var value, double width,{SetText setText= setStringText}) {
    return DataCell(Container(
        child: setText(value)));
  }
  static Text setStringText(var value){
    return Text(
          value == null ? "-" : value.toString(),
        );
  }
}
