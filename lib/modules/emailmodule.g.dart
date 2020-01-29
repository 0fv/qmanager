// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emailmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Email _$EmailFromJson(Map<String, dynamic> json) {
  return Email()
    ..protocol = json['protocol'] as String
    ..host = json['host'] as String
    ..port = json['port'] as int
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..from = json['from'] as String
    ..subject = json['subject'] as String
    ..template = json['template'] as String;
}

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
      'protocol': instance.protocol,
      'host': instance.host,
      'port': instance.port,
      'username': instance.username,
      'password': instance.password,
      'from': instance.from,
      'subject': instance.subject,
      'template': instance.template,
    };
