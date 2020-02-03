// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailschedulemodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailSchedule _$MailScheduleFromJson(Map<String, dynamic> json) {
  return MailSchedule(
    id: json['id'] as String,
    questionnaireEntityId: json['questionnaire_entity_id'] as String,
    memberGroupName:
        (json['member_group_name'] as List)?.map((e) => e as String)?.toList(),
    questionnaireTitle: json['questionnaire_title'] as String,
    sendingTime: json['sending_time'] == null
        ? null
        : DateTime.parse(json['sending_time'] as String),
  );
}

Map<String, dynamic> _$MailScheduleToJson(MailSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionnaire_entity_id': instance.questionnaireEntityId,
      'questionnaire_title': instance.questionnaireTitle,
      'member_group_name': instance.memberGroupName,
      'sending_time': instance.sendingTime?.toIso8601String(),
    };
