import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/jsonserializable.dart';

part 'maillogmodule.g.dart';

@JsonSerializable()
class MailLog implements JsonS {
  String id;
  @JsonKey(name: "questionnaire_entity_id")
  String questionnaireEntityId;
  String title;
  String name;
  String email;
  String status;
  String message;
  @JsonKey(name: "send_time")
  DateTime sendTime;

  MailLog(
      {this.id,
      this.title,
      this.name,
      this.email,
      this.status,
      this.questionnaireEntityId,
      this.sendTime,
      this.message});

  factory MailLog.fromJson(Map<String, dynamic> json) =>
      _$MailLogFromJson(json);

  Map<String, dynamic> toJson() => _$MailLogToJson(this);

  @override
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'questionnaire_entity_id': this.questionnaireEntityId,
        'title': this.title,
        'name': this.name,
        'email': this.email,
        'status': this.status,
        'message': this.message,
        'send_time': this.sendTime,
      };
}
