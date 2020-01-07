import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/answercellmodule.dart';
part 'commentmodule.g.dart';

@JsonSerializable(nullable: false)
class Comment implements AnswerCell {
  String type = "comment";
  String comment;
  Comment({this.comment});
  factory Comment.fromJosn(Map<String, dynamic> json)=>_$CommentFromJson(json);
  toJson() => _$CommentToJson(this);
}
