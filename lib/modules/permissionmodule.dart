import 'package:json_annotation/json_annotation.dart';
part 'permissionmodule.g.dart';

@JsonSerializable()
class Permission {
  bool questionnaire=false;
  @JsonKey(name: "question_cells")
  bool questionCells=false;
  @JsonKey(name: "question_groups")
  bool questionGroups=false;
  @JsonKey(name: "inquiry_crew")
  bool inquiryCrew=false;
  @JsonKey(name: "inquiry_config")
  bool inquiryConfig=false;
  @JsonKey(name: "result_show")
  bool resultShow=false;
  @JsonKey(name: "template_control")
  bool tmeplateControl=false;
  @JsonKey(name: "account_management")
  bool accountManagement=false;
  Permission();
  factory Permission.fromJson(Map<String,dynamic> json)=> _$PermissionFromJson(json);
  Map<String,dynamic> toJson()=>_$PermissionToJson(this);
}
