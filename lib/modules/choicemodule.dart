import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/answercellmodule.dart';

part 'choicemodule.g.dart';

@JsonSerializable(nullable: false)
class Choice implements AnswerCell {
  String type = "choice";
  Map<String, bool> choice;
  @JsonKey(name: 'is_multi')
  bool isMulti;
  Choice({this.choice, this.isMulti});
  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}
