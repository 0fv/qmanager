import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qmanager/api/processapi.dart';
import 'package:qmanager/modules/questionnaireentity.dart';
import 'package:qmanager/utils/datacellutil.dart';
import 'package:qmanager/utils/dateutil.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

class Finish extends StatelessWidget {
  final List<String> title = [
    "id",
    "问卷标题",
    "介绍",
    "开始时间",
    "结束时间",
    "创建人",
    "是否匿名",
    "被调查组"
  ];
  final ProcessApi processApi = ProcessApi();
  Future<dynamic> _getListData() async {
    return await processApi.getData(isFinish: 1);
  }

  List<Widget> _getTopBar(
      List<dynamic> selectedRow, BuildContext context, VoidCallback refresh) {
    return <Widget>[
      opButton(context, "刷新", Icon(Icons.refresh), () {
        refresh();
      }),
    ];
  }

  DataCell _getOC(BuildContext context, var row, VoidCallback refresh) {
    return DataCell(Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text("查看统计"),
            onPressed: () => {
              Navigator.pushNamed(context, '/resultStatistics',
                  arguments: {'id': row['id']})
            },
          ),
          FlatButton(
              child: Text("再次开启并延长时间"),
              onPressed: () async {
                DateTime from = await showDatePicker(
                  context: context,
                  locale: Locale("zh"),
                  initialDate: DateTime.parse(row["to"]),
                  firstDate: DateTime.parse("2020-01-01"),
                  lastDate: DateTime.parse("2030-12-12"),
                );
                if (from != null) {
                  TimeOfDay f = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  DateTime newDate = DateUtil.setTime(from, f);
                  var updateMap = {
                    "id": row["id"],
                    "to": DateUtil.format2(newDate)
                  };
                  try {
                    await processApi.updateDate(updateMap);
                    popToast("修改成功", context);
                    refresh();
                  } on DioError catch (e) {
                    popToast(e.message, context);
                  }
                }
              }),
        ],
      ),
    ));
  }

  DataCell _getDataCell(int index, var value) {
    if (index == 6) {
      return DataCellUtil.getDataCell(value, 200,
          setText: (value) => value == 1 ? Text("否") : Text("是"));
    } else if (index == 7) {
      return DataCellUtil.getDataCell(value, 200, setText: (value) {
        if (value == null || value == []) {
          return Text("-");
        } else {
          String s = "";
          value.forEach((v) {
            s += (v + " ");
          });
          return Text(s);
        }
      });
    } else {
      return DataCellUtil.getDataCell(value, 200);
    }
  }

  Map<String, dynamic> _getMap(var m) {
    return QuestionnaireEntity.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: MyDataTable(
      _getListData,
      title,
      QuestionnaireEntity(
          id: "id",
          title: "name",
          introduce: "f",
          from: DateTime.now(),
          to: DateTime.now(),
          createdAccount: "f",
          isAnonymous: false,
          memberGroupName: []),
      "已完成的问卷实例",
      _getTopBar,
      _getMap,
      getDataCell: _getDataCell,
      getOperationCell: _getOC,
    ));
  }
}
