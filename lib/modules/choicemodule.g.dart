// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choicemodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Choice _$ChoiceFromJson(Map<String, dynamic> json) {
  return Choice(
    choice: (json['choice'] as List)?.map((e) => e as String)?.toList(),
    isMulti: json['is_multi'] as bool,
  )..type = json['type'] as String;
}

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'type': instance.type,
      'choice': instance.choice,
      'is_multi': instance.isMulti,
    };
