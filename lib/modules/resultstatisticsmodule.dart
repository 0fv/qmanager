import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/resultstatisticsgroupmodule.dart';

part 'resultstatisticsmodule.g.dart';

@JsonSerializable()
class ResultStatistics {
  String id;
  String title;
  @JsonKey(name: 'choice_statistics_groups')
  List<ResultStatisticsGroup> choiceStatisticsGroups;

  ResultStatistics({this.id, this.title, this.choiceStatisticsGroups});

  factory ResultStatistics.fromJson(Map<String, dynamic> json)=> _$ResultStatisticsFromJson(json);

  Map<String, dynamic> toJson()=> _$ResultStatisticsToJson(this);
}