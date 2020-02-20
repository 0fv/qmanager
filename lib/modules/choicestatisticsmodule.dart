import 'package:json_annotation/json_annotation.dart';

part 'choicestatisticsmodule.g.dart';

@JsonSerializable()
class ChoiceStatistics {
	String title;
	Map<String,int> choice;
  @JsonKey(name: "must_answer")
	bool mustAnswer;

	ChoiceStatistics({this.title, this.choice, this.mustAnswer});

	factory ChoiceStatistics.fromJson(Map<String, dynamic> json)=> _$ChoiceStatisticsFromJson(json);

	Map<String, dynamic> toJson() => _$ChoiceStatisticsToJson(this);
}