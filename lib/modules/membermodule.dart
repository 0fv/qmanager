import 'package:json_annotation/json_annotation.dart';
import 'package:qmanager/modules/jsonserializable.dart';

part 'membermodule.g.dart';

@JsonSerializable(includeIfNull: false)
class Member implements JsonS {
  String id;
  String name;
  String email;
  @JsonKey(name: "additional_info")
  String additionalInfo;
  Member({this.id, this.name, this.email, this.additionalInfo});
  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MemberToJson(this);

  @override
  Map<String, dynamic> toMap() => {
        'id': this.id,
        'name': this.name,
        'email': this.email,
        'additional_info': this.additionalInfo,
      };
}
