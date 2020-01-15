// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    username: json['username'] as String,
    passwd: json['passwd'] as String,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastLogin: json['last_login'] == null
        ? null
        : DateTime.parse(json['last_login'] as String),
    isSuper: json['is_super'] as int,
    permission: json['permission'] == null
        ? null
        : Permission.fromJson(json['permission'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('username', instance.username);
  writeNotNull('passwd', instance.passwd);
  writeNotNull('created_time', instance.createdTime?.toIso8601String());
  writeNotNull('last_login', instance.lastLogin?.toIso8601String());
  writeNotNull('is_super', instance.isSuper);
  writeNotNull('permission', instance.permission);
  return val;
}
