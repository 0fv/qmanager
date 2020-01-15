import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/jsonserializable.dart';
import 'package:qmanager/modules/permissionmodule.dart';

part 'usermodule.g.dart';

@JsonSerializable(includeIfNull: false)
class User implements JsonS {
  String id;
  String username;
  String passwd;
  @JsonKey(name: "created_time")
  DateTime createdTime;
  @JsonKey(name: "last_login")
  DateTime lastLogin;
  @JsonKey(name: "is_super")
  int isSuper;
  Permission permission;
  User(
      {this.id, this.username,this.passwd,this.createdTime, this.lastLogin, this.isSuper,this.permission});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'username': this.username,
        'created_time': this.createdTime,
        'last_login': this.lastLogin,
        'is_super': this.isSuper,
      };
}
