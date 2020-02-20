// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resultstatisticsgroupmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultStatisticsGroup _$ResultStatisticsGroupFromJson(
    Map<String, dynamic> json) {
  return ResultStatisticsGroup(
    groupTitle: json['group_title'] as String,
    choiceStatistics: (json['choice_statistics'] as List)
        ?.map((e) => e == null
            ? null
            : ChoiceStatistics.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultStatisticsGroupToJson(
        ResultStatisticsGroup instance) =>
    <String, dynamic>{
      'group_title': instance.groupTitle,
      'choice_statistics': instance.choiceStatistics,
    };
