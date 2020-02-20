// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choicestatisticsmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoiceStatistics _$ChoiceStatisticsFromJson(Map<String, dynamic> json) {
  return ChoiceStatistics(
    title: json['title'] as String,
    choice: (json['choice'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    mustAnswer: json['must_answer'] as bool,
  );
}

Map<String, dynamic> _$ChoiceStatisticsToJson(ChoiceStatistics instance) =>
    <String, dynamic>{
      'title': instance.title,
      'choice': instance.choice,
      'must_answer': instance.mustAnswer,
    };
