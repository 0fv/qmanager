import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/answercellmodule.dart';

part 'inquirydatemodule.g.dart';

@JsonSerializable()
class InquireDate implements AnswerCell {
  String type = "date";
  DateTime date;
  InquireDate({this.date});
  factory InquireDate.fromJson(Map<String,dynamic> json)=> _$InquireDateFromJson(json);
  toJson() => _$InquireDateToJson(this);
}
