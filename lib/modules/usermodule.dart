import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/jsonserializable.dart';

part 'usermodule.g.dart';

@JsonSerializable()
class User implements JsonS {
  String id;
  String username;
  @JsonKey(name: "created_time")
  DateTime createdTime;
  @JsonKey(name: "last_login")
  DateTime lastLogin;
  @JsonKey(name: "is_super")
  String isSuper;
  User(
      {this.id, this.username, this.createdTime, this.lastLogin, this.isSuper});
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
