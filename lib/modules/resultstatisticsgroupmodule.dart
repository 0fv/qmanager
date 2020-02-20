import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/choicestatisticsmodule.dart';
part 'resultstatisticsgroupmodule.g.dart';
@JsonSerializable()
class ResultStatisticsGroup {
  @JsonKey(name:'group_title')
  String groupTitle;
  @JsonKey(name: 'choice_statistics')
  List<ChoiceStatistics> choiceStatistics;

  ResultStatisticsGroup({this.groupTitle, this.choiceStatistics});

  factory ResultStatisticsGroup.fromJson(Map<String, dynamic> json)=>_$ResultStatisticsGroupFromJson(json);

  Map<String, dynamic> toJson() =>_$ResultStatisticsGroupToJson(this);
}