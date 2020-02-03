import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/jsonserializable.dart';

part 'mailschedulemodule.g.dart';

@JsonSerializable()
class MailSchedule implements JsonS {
  String id;
  @JsonKey(name: "questionnaire_entity_id")
  String questionnaireEntityId;
  @JsonKey(name: "questionnaire_title")
  String questionnaireTitle;
  @JsonKey(name: "member_group_name")
  List<String> memberGroupName;
  @JsonKey(name: "sending_time")
  DateTime sendingTime;

  MailSchedule(
      {this.id,
      this.questionnaireEntityId,
      this.memberGroupName,
      this.questionnaireTitle,
      this.sendingTime});

  factory MailSchedule.fromJson(Map<String, dynamic> json) =>
      _$MailScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$MailScheduleToJson(this);

  @override
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'questionnaire_entity_id': this.questionnaireEntityId,
        'questionnaire_title': this.questionnaireTitle,
        'member_group_name': this.memberGroupName,
        'sending_time': this.sendingTime
      };
}
