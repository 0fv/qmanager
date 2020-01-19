import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/questioncellmodule.dart';

part 'questiongroupmodule.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class QuestionGroup {
  String title;
  @JsonKey(name: "question_cells",)
  List<QuestionCell> questionCells;
  QuestionGroup({this.title, this.questionCells});

  factory QuestionGroup.fromJson(Map<String, dynamic> json)=> _$QuestionGroupFromJson(json);

  Map<String, dynamic> toJson() =>_$QuestionGroupToJson(this);
}