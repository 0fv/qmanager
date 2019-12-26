
import 'package:flutter/material.dart';
import 'package:qmanager/api/questionnaireapi.dart';
import 'package:qmanager/common/tabletitle.dart';
import 'package:qmanager/modules/jsonserializable.dart';
import 'package:qmanager/modules/questionnairemodule.dart';
import 'package:qmanager/widget/mytable.dart';

class MyDataTable extends StatefulWidget {
  MyDataTable({Key key}) : super(key: key);

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  Questionnaireapi questionnaireapi = Questionnaireapi();
  List<Map<String, dynamic>> tableData;
  MyTable _myTable;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  int _totalPage;
  int _currentPage = 1;
  int _totalRow;
  int _defaultRowPageCount = 15;
  JsonSerializable _obj = Questionnaire();
  Future<dynamic> setMyTable(page, pageSize) async {
    return await questionnaireapi.getQuestionnariePage(
        page: page, pageSize: pageSize);
  }

  @override
  Widget build(BuildContext context) {
    if (_myTable == null) {
      return FutureBuilder(
        future: setMyTable(_currentPage, _defaultRowPageCount),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return getLoadingWidget();
            case ConnectionState.waiting:
              return getLoadingWidget();
            case ConnectionState.active:
              return getLoadingWidget();
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error1: ${snapshot.error}');
              this._myTable = MyTable(snapshot.data["data"]["data"], this._obj);
              return getPageinatedDataTable();
          }
          return Text("error");
        },
      );
    } else {
      return getPageinatedDataTable();
    }
  }

  Widget getLoadingWidget() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        )
      ],
    );
  }

  Widget getPageinatedDataTable() {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        columnSpacing: 200,
        availableRowsPerPage: [10,15,20],
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Icon(Icons.edit),
                Text("编辑"),
              ],
            ),
            onPressed: () {},
          ),
          FlatButton(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                Text("删除"),
              ],
            ),
            onPressed: () {},
          )
        ],
        rowsPerPage: this._defaultRowPageCount,
        onRowsPerPageChanged: (value) {
          setState(() {
            this._defaultRowPageCount = value;
          });
        },
        sortColumnIndex: this._sortColumnIndex,
        initialFirstRowIndex: 0,
        sortAscending: this._sortAscending,
        onPageChanged: (value) {
          //to-do
          print('$value');
        },
        onSelectAll: this._myTable.selectAll,
        header: Text('text'),
        columns: questionnaireTitle.map((k) {
          return DataColumn(label: Text(k), onSort: _sort);
        }).toList(),
        source: this._myTable,
      ),
    );
  }

  void _sort(int index, bool b) {
    _myTable.sort(index, b, (var m) {
      return Questionnaire.fromJson(m).toMap();
    });
    setState(() {
      this._sortColumnIndex = index;
      this._sortAscending = b;
    });
  }
}
