import 'package:qmanager/modules/answercellmodule.dart';
import 'package:json_annotation/json_annotation.dart';
part 'questioncellmodule.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionCell {
  String title;
  @JsonKey(name: "answer_cells",fromJson: AnswerCell.fromJson)
  List<AnswerCell> answerCells;
  QuestionCell({this.title, this.answerCells});
  factory QuestionCell.fromJson(Map<String,dynamic> json)=> _$QuestionCellFromJson(json);
  toJson()=> _$QuestionCellToJson(this);

}
