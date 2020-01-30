import 'package:flutter/material.dart';
import 'package:qmanager/api/membergroupapi.dart';
import 'package:qmanager/modules/membergroupmodule.dart';
import 'package:qmanager/widget/table/mydatatable.dart';
import 'package:qmanager/widget/topbar/opbutton.dart';

Future<List<MemberGroup>> memberGroupTableDiolog(BuildContext context) =>
    showDialog<List<MemberGroup>>(
        context: context,
        builder: (context) => Container(
              width: 800,
              child: MemberGroupTable(),
            ));

class MemberGroupTable extends StatelessWidget {
  final List<String> _title = ["id", "名称", "创建时间", "创建账户", "最后修改时间", "最后修改人"];
  final MemberGroupApi memberGroupApi = MemberGroupApi();

  Future<dynamic> _getListData() async {
    return await memberGroupApi.getData();
  }

  List<Widget> _getTopBar(
      List<dynamic> selectedRow, BuildContext context, VoidCallback refresh) {
    return <Widget>[
      opButton(
          context,
          "添加",
          Icon(
            Icons.add,
            color: Colors.blueGrey,
          ),
          selectedRow.isEmpty
              ? null
              : () {
                  Navigator.of(context).pop(selectedRow.map((mg) {
                    MemberGroup m =
                        MemberGroup(id: mg['id'], groupName: mg['group_name']);
                    print(m.toJson());
                    return m;
                  }).toList());
                }),
      opButton(context, "取消", Icon(Icons.cancel), () {
        Navigator.of(context).pop();
      })
    ];
  }

  Map<String, dynamic> _getMap(var m) {
    return MemberGroup.fromJson(m).toMap();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(246, 10, 246, 0),
        child: MyDataTable(
          _getListData,
          _title,
          MemberGroup(
              id: "id",
              groupName: "name",
              createdTime: DateTime.now(),
              createdAccount: "x",
              editedTime: DateTime.now(),
              editedAccount: "x"),
          "成员组管理",
          _getTopBar,
          _getMap,
        ));
  }
}
