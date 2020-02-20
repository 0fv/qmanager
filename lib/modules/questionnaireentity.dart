import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/jsonserializable.dart';
import 'package:qmanager/utils/boolutil.dart';

part 'questionnaireentity.g.dart';

@JsonSerializable(nullable: false)
class QuestionnaireEntity implements JsonS {
  String id;
  String title;
  String introduce;
  DateTime from;
  DateTime to;
  @JsonKey(name: "created_account")
  String createdAccount;
  @JsonKey(name: "is_anonymous",fromJson: BoolUtil.getBool)
  bool isAnonymous;
  @JsonKey(name: "member_group_name")
  List<String> memberGroupName;

  QuestionnaireEntity(
      {this.id,
      this.title,
      this.introduce,
      this.from,
      this.to,
      this.createdAccount,
      this.isAnonymous,
      this.memberGroupName});

  factory QuestionnaireEntity.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireEntityFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionnaireEntityToJson(this);

  @override
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'title': this.title,
        'introduce': this.introduce,
        'from': this.from,
        'to': this.to,
        'created_account': this.createdAccount,
        'is_anonymous': this.isAnonymous,
        'member_group_name': this.memberGroupName,
      };
}
