import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/jsonserializable.dart';
import 'package:qmanager/modules/questiongroupmodule.dart';
part 'questionnairemodule.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Questionnaire implements JsonS {
  String id;
  String uuid;
  String name;
  String introduce;
  @JsonKey(name: "created_time")
  DateTime createdTime;
  @JsonKey(name: "created_account")
  String createdAccount;
  @JsonKey(name: "edited_time")
  DateTime editedTime;
  @JsonKey(name: "edited_account")
  String editedAccount;
  @JsonKey(name: "question_groups")
  List<QuestionGroup> questionGroups;
  Questionnaire(
      {this.id,
      this.uuid,
      this.name,
      this.introduce,
      this.createdTime,
      this.editedTime,
      this.createdAccount,
      this.editedAccount,
      this.questionGroups});

  factory Questionnaire.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuestionnaireToJson(this);
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'introduce': introduce,
        'created_time': this.createdTime,
        'created_account': this.createdAccount,
        'edited_time': this.editedTime,
        'edited_account': this.editedAccount,
      };
}
