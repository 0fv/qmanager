import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

void main() {
  getMap();
  while (r) {
    sleep(Duration(seconds: 2));
    print(x);
  }
  print('finish');
}

bool r = true;
var x;
getMap() {
  var dio = Dio();
  Map<String, dynamic> m = Map();
  m["page"] = 1;
  m["pageSize"] = 2;
print('start');
  dio
      .get("http://127.0.0.1:8000/questionnaire", queryParameters: m)
      .then((onValue) {
    x = onValue;
    r = false;
  });
  print('finish');
}
