import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/answercellmodule.dart';

part 'choicemodule.g.dart';

@JsonSerializable(nullable: false)
class Choice implements AnswerCell {
  final String type = "choice";
  Map<String, bool> choice;
  bool isMulti;
  Choice({this.choice, this.isMulti});
  factory Choice.from(Map<String, dynamic> json) => _$ChoiceFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}
