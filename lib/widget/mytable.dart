import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:qmanager/modules/jsonserializable.dart';

class MyTable extends DataTableSource {
  List<dynamic> data;
  JsonSerializable obj;
  bool _isRowCountApproximate = false;
  HashSet<int> _selectedSet = HashSet();
  MyTable(this.data, this.obj);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index > data.length) return null;
    final d = this.data[index];
    return DataRow.byIndex(
        index: index,
        selected: _selectedSet.contains(index),
        onSelectChanged: (isSelected) {
          if (isSelected) {
            _selectedSet.add(index);
          } else {
            _selectedSet.remove(index);
          }
          notifyListeners();
        },
        cells: obj
            .toJson()
            .keys
            .map((value) => DataCell(Text(d[value] == null ? "-" : d[value])))
            .toList());
  }

  @override
  bool get isRowCountApproximate => _isRowCountApproximate;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => _selectedSet.length;

  void selectAll(bool checked) {
    if (checked) {
      for (var i = 0; i < this.data.length; i++) {
        this._selectedSet.add(i);
      }
    } else {
      this._selectedSet.clear();
    }
    notifyListeners();
  }

  void sort(int index, bool b, toMap(var m)) {
    data.sort((var s1, var s2) {
      Map<String, dynamic> m1 = toMap(s1);
      Map<String, dynamic> m2 = toMap(s2);
      String key = m1.keys.toList()[index];
      final Comparable s1Value = m1[key];
      final Comparable s2Value = m2[key];
      if (!b) {
        return s1Value.compareTo(s2Value);
      } else {
        return s2Value.compareTo(s1Value);
      }
    });
    notifyListeners();
  }
}
