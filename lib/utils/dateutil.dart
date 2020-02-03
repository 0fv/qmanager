import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class DateUtil {
  static DateTime getNow() {
    var d = DateTime.now();
    var t = TimeOfDay.now();
    return d.subtract(Duration(hours: t.hour, minutes: t.minute));
  }

  static DateTime getPureDate(DateTime dateTime) {
    var t = TimeOfDay.fromDateTime(dateTime);
    return dateTime.subtract(Duration(hours: t.hour, minutes: t.minute));
  }

  static DateTime setTime(DateTime dateTime, TimeOfDay day) {
    if (day != null) {
      return DateTime(
          dateTime.year, dateTime.month, dateTime.day, day.hour, day.minute);
    } else {
      return dateTime;
    }
  }

  static String format(DateTime dateTime) {
    return formatDate(dateTime,  [yyyy, "-", mm, "-", "dd"," ",HH,":",nn]);
  }
   static String format2(DateTime dateTime) {
    return formatDate(dateTime,  [yyyy, "-", mm, "-", "dd"," ",HH,":",nn,":",ss]);
  }
}
