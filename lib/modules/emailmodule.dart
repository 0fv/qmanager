import 'package:json_annotation/json_annotation.dart';
part 'emailmodule.g.dart';

@JsonSerializable(nullable: false)
class Email {
  String protocol="stmp";
  String host;
  int port;
  String username;
  String password;
  String from;
  String subject;
  String template;
  Email();
  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);

  Map<String, dynamic> toJson() => _$EmailToJson(this);
}
