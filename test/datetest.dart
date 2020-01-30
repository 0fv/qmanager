import 'package:flutter/material.dart';

main(){
  var  d =DateTime.now();
  var t = TimeOfDay.now();
  print( d.subtract(Duration(hours: t.hour,minutes: t.minute)).toLocal());
}