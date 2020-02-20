// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maillogmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailLog _$MailLogFromJson(Map<String, dynamic> json) {
  return MailLog(
    id: json['id'] as String,
    title: json['title'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    status: BoolUtil.getBool(json['status'] as int),
    questionnaireEntityId: json['questionnaire_entity_id'] as String,
    sendTime: json['send_time'] == null
        ? null
        : DateTime.parse(json['send_time'] as String),
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$MailLogToJson(MailLog instance) => <String, dynamic>{
      'id': instance.id,
      'questionnaire_entity_id': instance.questionnaireEntityId,
      'title': instance.title,
      'name': instance.name,
      'email': instance.email,
      'status': instance.status,
      'message': instance.message,
      'send_time': instance.sendTime?.toIso8601String(),
    };
