import 'package:json_annotation/json_annotation.dart';
part 'permissionmodule.g.dart';

@JsonSerializable()
class Permission {
  String questionnaire='';
  @JsonKey(name: "question_cells")
  String questionCells='';
  @JsonKey(name: "question_groups")
  String questionGroups='';
  @JsonKey(name: "inquiry_crew")
  String inquiryCrew='';
  @JsonKey(name: "inquiry_config")
  String inquiryConfig='';
  @JsonKey(name: "result_show")
  String resultShow='';
  @JsonKey(name: "template_control")
  String templateControl='';
  @JsonKey(name: "account_management")
  String accountManagement='';
  @JsonKey(name: "mail_management")
	String mailManagement='';
  Permission();
  factory Permission.fromJson(Map<String,dynamic> json)=> _$PermissionFromJson(json);
  Map<String,dynamic> toJson()=>_$PermissionToJson(this);
}
