// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    username: json['username'] as String,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastLogin: json['last_login'] == null
        ? null
        : DateTime.parse(json['last_login'] as String),
    isSuper: json['is_super'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_login': instance.lastLogin?.toIso8601String(),
      'is_super': instance.isSuper,
    };
