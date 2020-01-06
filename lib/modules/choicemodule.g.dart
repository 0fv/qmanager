// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choicemodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Choice _$ChoiceFromJson(Map<String, dynamic> json) {
  return Choice(
    choice: Map<String, bool>.from(json['choice'] as Map),
    isMulti: json['isMulti'] as bool,
  );
}

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'choice': instance.choice,
      'isMulti': instance.isMulti,
    };
