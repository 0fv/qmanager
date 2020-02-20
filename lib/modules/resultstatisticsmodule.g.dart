// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultstatisticsmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultStatistics _$ResultStatisticsFromJson(Map<String, dynamic> json) {
  return ResultStatistics(
    id: json['id'] as String,
    title: json['title'] as String,
    choiceStatisticsGroups: (json['choice_statistics_groups'] as List)
        ?.map((e) => e == null
            ? null
            : ResultStatisticsGroup.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultStatisticsToJson(ResultStatistics instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'choice_statistics_groups': instance.choiceStatisticsGroups,
    };
