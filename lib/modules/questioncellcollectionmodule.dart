import 'package:qmanager/modules/answercellmodule.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/jsonserializable.dart';
part 'questioncellcollectionmodule.g.dart';

@JsonSerializable(includeIfNull: false,explicitToJson: true)
class QuestionCellCollection implements JsonS{
  String id;
  String title;
  String classification;
  @JsonKey(name: "created_time")
  DateTime createdTime;
  @JsonKey(name: "created_account")
  String createdAccount;
  @JsonKey(name:"edited_accout")
  String editedAccount;
  @JsonKey(name: "edited_time")
  DateTime editedTime;
  @JsonKey(name: "answer_cells",fromJson: AnswerCell.fromJson)
  List<AnswerCell> answerCells;
  QuestionCellCollection({
    this.id,this.title,this.classification,this.createdAccount,this.createdTime,this.editedAccount,this.editedTime,this.answerCells});
  factory QuestionCellCollection.fromJson(Map<String,dynamic> json)=> _$QuestionCellCollectionFromJson(json);
  toJson()=> _$QuestionCellCollectionToJson(this);

  @override
  Map<String, dynamic> toMap()=>{
      'id': this.id,
      'title': this.title,
      'classification': this.classification,
      'created_time': this.createdTime,
      'created_account': this.createdAccount,
      'edited_accout': this.editedAccount,
      'edited_time': this.editedTime,
  };


}