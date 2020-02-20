// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaireentity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionnaireEntity _$QuestionnaireEntityFromJson(Map<String, dynamic> json) {
  return QuestionnaireEntity(
    id: json['id'] as String,
    title: json['title'] as String,
    introduce: json['introduce'] as String,
    from: DateTime.parse(json['from'] as String),
    to: DateTime.parse(json['to'] as String),
    createdAccount: json['created_account'] as String,
    isAnonymous: BoolUtil.getBool(json['is_anonymous'] as int),
    memberGroupName:
        (json['member_group_name'] as List).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$QuestionnaireEntityToJson(
        QuestionnaireEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'introduce': instance.introduce,
      'from': instance.from.toIso8601String(),
      'to': instance.to.toIso8601String(),
      'created_account': instance.createdAccount,
      'is_anonymous': instance.isAnonymous,
      'member_group_name': instance.memberGroupName,
    };
