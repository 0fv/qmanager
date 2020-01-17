import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:more/iterable.dart';
import 'package:qmanager/common/common.dart';
import 'package:qmanager/modules/jsonserializable.dart';
import 'package:qmanager/utils/datacellutil.dart';
import 'package:qmanager/widget/misc.dart';
import 'package:qmanager/widget/table/mytable.dart';
import 'package:toast/toast.dart';

class MyDataTable extends StatefulWidget {
  final List<String> titleList;
  final GetListData getListData;
  final GetOperationCell getOperationCell;
  final JsonS obj;
  final String titleName;
  final GetTopButton getTopButton;
  final GetDataCell getDataCell;
  final GetType getMap;
  MyDataTable(this.getListData, this.titleList, this.obj, this.titleName,
      this.getTopButton, this.getMap,
      {this.getDataCell, this.getOperationCell, Key key})
      : super(key: key);

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  List<Map<String, dynamic>> tableData;
  MyTable _myTable;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  int _defaultRowPageCount = 15;
  List<dynamic> _selectedRow = [];
  List<dynamic> _allC = [];
  String _search;
  double _cellWidth;
  final GlobalKey globalKey = GlobalKey();

  DateTime _from = DateTime.parse('2019-12-01');
  DateTime _to = DateTime.parse("2019-12-02");

  @override
  void dispose() {
    this._myTable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int row = widget.titleList.length;
    if (widget.getOperationCell != null) {
      row++;
    }
    double cellwidth = (width-1000) / row;
    if (cellwidth != this._cellWidth) {
      if (cellwidth <= 50) {
        setState(() {
          this._cellWidth = 50;
        });
      } else {
        setState(() {
          this._cellWidth = cellwidth;
        });
      }
    }
    if (this._myTable == null) {
      return FutureBuilder(
        future: widget.getListData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return loadingWidget(context);
            case ConnectionState.waiting:
              return loadingWidget(context);
            case ConnectionState.active:
              return loadingWidget(context);
            case ConnectionState.done:
              if (snapshot.hasError) {
                DioError error = snapshot.error as DioError;
                var msg = error.message;
                Future.delayed(Duration(seconds: 1)).then((v) {
                  Toast.show("$msg", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                });
              } else {
                this._allC = snapshot.data["data"];
                print(this._allC);
              }

              this._myTable = MyTable(this._allC, _getCells);
              return getPageinatedDataTable(context);
          }
          return Text("error");
        },
      );
    } else {
      return getPageinatedDataTable(context);
    }
  }

  List<DataCell> _getCells(var row) {
    // List<DataCell> cells = widget.obj
    //     .toJson()
    //     .keys
    //     .map((value) => DataCell(Container(
    //           width: 200,
    //           child: Text(
    //             row[value] == null ? "-" : row[value].toString(),
    //           ),
    //         )))
    //     .toList();
    List<String> list = widget.obj.toMap().keys.toList();
    List<DataCell> cells = indexed(list).map((e) {
      if (widget.getDataCell == null) {
        return DataCellUtil.getDataCell(row[e.value], 100);
      } else {
        return widget.getDataCell(e.index, row[e.value]);
      }
    }).toList();
    if (widget.getOperationCell != null) {
      cells.add(widget.getOperationCell(context, row,_refresh));
    }
    return cells;
  }

  _refresh() {
    setState(() {
      this._myTable = null;
    });
  }

  List<Widget> setAction(BuildContext context) {
    List actions = widget.getTopButton(this._selectedRow, context, _refresh);
    actions.insert(0, searchSelete(context));
    actions.insert(1, searchBox(context));
    return actions;
  }

  Widget searchSelete(BuildContext context) {
    List<DropdownMenuItem<String>> searchContent = [];
    List<String> keyList = widget.obj.toMap().keys.toList();
    for (var i = 0; i < widget.titleList.length; i++) {
      searchContent.add(DropdownMenuItem(
          value: keyList[i],
          child: Text(widget.titleList[i], style: TextStyle(fontSize: 15))));
    }

    return Builder(
      builder: (context) {
        return DropdownButton(
          items: searchContent,
          hint: Text(
            "搜索类型选择",
            style: TextStyle(fontSize: 15),
          ),
          onChanged: (v) {
            setState(() {
              this._search = v;
            });
          },
          value: this._search,
        );
      },
    );
  }

  Widget searchBox(BuildContext context) {
    if (this._search == null) {
      return Container();
    } else {
      var type = widget.obj.toMap()[this._search];
      if (type is DateTime) {
        return Builder(
          builder: (context) {
            return Row(
              children: <Widget>[
                MaterialButton(
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: <Widget>[Icon(Icons.date_range), Text("选择时间")],
                  ),
                  onPressed: searchDate,
                )
              ],
            );
          },
        );
      } else {
        return Builder(
          builder: (context) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 30, maxWidth: 200),
              child: TextField(
                maxLines: 1,
                autofocus: false,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    counterStyle: TextStyle(fontSize: 15),
                    hintText: "搜索",
                    prefixIcon: Icon(Icons.search)),
                onChanged: (v) {
                  searchString(v);
                },
              ),
            );
          },
        );
      }
    }
  }

  searchString(String str) {
    List<dynamic> l = [];
    RegExp k = new RegExp(r".*" + str + ".*");
    for (var e in this._allC) {
      if (k.hasMatch(e[this._search])) {
        l.add(e);
      }
    }
    setState(() {
      this._myTable = MyTable(l, _getCells);
    });
  }

  searchDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: this._from,
        initialLastDate: this._to,
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2022));
    if (picked?.length == 2) {
      print(picked);
      DateTime from = picked[0];
      DateTime to = picked[1].add(Duration(hours: 24));
      List l = [];
      for (var e in this._allC) {
        DateTime d = DateTime.parse(e[this._search]);
        int f = d.compareTo(from);
        int t = d.compareTo(to);
        if (f >= 0 && t <= 0) {
          l.add(e);
        }
      }
      setState(() {
        this._from = from;
        this._to = to;
        this._myTable = MyTable(l, _getCells);
      });
    }
    if (picked?.length == 1) {
      DateTime from = picked[0];
      DateTime to = picked[0].add(Duration(hours: 24));
      List l = [];
      for (var e in this._allC) {
        DateTime d = DateTime.parse(e[this._search]);
        if (d.isAfter(from) && d.isBefore(to)) {
          l.add(e);
        }
      }
      setState(() {
        this._from = from;
        this._to = to;
        this._myTable = MyTable(l, _getCells);
      });
    }
  }

  Widget getPageinatedDataTable(BuildContext context) {
    this._myTable.addListener(() {
      var c = this._myTable.getChecked();
      if (this._selectedRow != c) {
        setState(() {
          this._selectedRow = c;
        });
      }
    });

    return Builder(
      builder: (context) => SingleChildScrollView(
        child: PaginatedDataTable(
          availableRowsPerPage: [10, 15, 20],
          actions: setAction(context),
          rowsPerPage: this._defaultRowPageCount,
          onRowsPerPageChanged: (value) {
            setState(() {
              this._defaultRowPageCount = value;
            });
          },
          sortColumnIndex: this._sortColumnIndex,
          initialFirstRowIndex: 0,
          sortAscending: this._sortAscending,
          onSelectAll: this._myTable.selectAll,
          header: Text(widget.titleName),
          columns: getColumns(),
          source: this._myTable,
        ),
      ),
    );
  }

  List<DataColumn> getColumns() {
    List<DataColumn> c = widget.titleList.map((k) {
      return DataColumn(
          label: Container(
            width: this._cellWidth,
            child: Text(k),
          ),
          onSort: _sort);
    }).toList();
    if (widget.getOperationCell != null) {
      c.add(DataColumn(
          label: Container(
        width: this._cellWidth,
        alignment: Alignment.center,
        child: Text("操作"),
      )));
    }
    return c;
  }

  void _sort(int index, bool b) {
    _myTable.sort(index, b, widget.getMap);
    setState(() {
      this._sortColumnIndex = index;
      this._sortAscending = b;
    });
  }
}
