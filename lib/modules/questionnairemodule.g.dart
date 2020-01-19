// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnairemodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Questionnaire _$QuestionnaireFromJson(Map<String, dynamic> json) {
  return Questionnaire(
    id: json['id'] as String,
    uuid: json['uuid'] as String,
    name: json['name'] as String,
    introduce: json['introduce'] as String,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    editedTime: json['edited_time'] == null
        ? null
        : DateTime.parse(json['edited_time'] as String),
    createdAccount: json['created_account'] as String,
    editedAccount: json['edited_account'] as String,
    questionGroups: (json['question_groups'] as List)
        ?.map((e) => e == null
            ? null
            : QuestionGroup.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionnaireToJson(Questionnaire instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('uuid', instance.uuid);
  writeNotNull('name', instance.name);
  writeNotNull('introduce', instance.introduce);
  writeNotNull('created_time', instance.createdTime?.toIso8601String());
  writeNotNull('created_account', instance.createdAccount);
  writeNotNull('edited_time', instance.editedTime?.toIso8601String());
  writeNotNull('edited_account', instance.editedAccount);
  writeNotNull('question_groups',
      instance.questionGroups?.map((e) => e?.toJson())?.toList());
  return val;
}
