import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/jsonserializable.dart';

part 'membergroupmodule.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class MemberGroup implements JsonS {
  String id;
  @JsonKey(name: "group_name")
  String groupName;
  @JsonKey(name: "created_time")
  DateTime createdTime;
  @JsonKey(name: "created_account")
  String createdAccount;
  @JsonKey(name: "edited_account")
  String editedAccount;
  @JsonKey(name: "edited_time")
  DateTime editedTime;
  MemberGroup(
      {this.id,
      this.groupName,
      this.createdAccount,
      this.createdTime,
      this.editedAccount,
      this.editedTime});
  factory MemberGroup.fromJson(Map<String, dynamic> json) =>
      _$MemberGroupFromJson(json);

  bool operator ==(o) =>
      o is MemberGroup && id == o.id && groupName == o.groupName;
  @override
  int get hashCode => this.id.hashCode;

  Map<String, dynamic> toJson() => _$MemberGroupToJson(this);
  @override
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'group_name': this.groupName,
        'created_time': this.createdTime,
        'created_account': this.createdAccount,
        'edited_time': this.editedTime,
        'edited_account': this.editedAccount
      };
}
