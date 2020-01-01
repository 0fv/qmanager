import 'package:qmanager/modules/answercellmodule.dart';

class InquireDate implements AnswerCell {
  final String type = "date";
  DateTime date;
  InquireDate({this.date});
}
