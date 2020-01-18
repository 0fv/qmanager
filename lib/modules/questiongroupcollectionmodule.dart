import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/jsonserializable.dart';
import 'package:qmanager/modules/questioncellmodule.dart';
part 'questiongroupcollectionmodule.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class QuestionGroupCollection implements JsonS {
  String id;
  String title;
  String classification;
  @JsonKey(name: "created_time")
  DateTime createdTime;
  @JsonKey(name: "created_account")
  String createdAccount;
  @JsonKey(name: "edited_accout")
  String editedAccount;
  @JsonKey(name: "edited_time")
  DateTime editedTime;
  @JsonKey(name: "question_cells")
  List<QuestionCell> questionCells;
  QuestionGroupCollection(
      {this.id,
      this.title,
      this.classification,
      this.createdAccount,
      this.createdTime,
      this.editedAccount,
      this.editedTime,
      this.questionCells});
  factory QuestionGroupCollection.fromJson(Map<String, dynamic> json) =>
      _$QuestionGroupCollectionFromJson(json);
  toJson() => _$QuestionGroupCollectionToJson(this);

  @override
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'title': this.title,
        'classification': this.classification,
        'created_time': this.createdTime,
        'created_account': this.createdAccount,
        'edited_time': this.editedTime,
        'edited_account': this.editedAccount,
      };
}
