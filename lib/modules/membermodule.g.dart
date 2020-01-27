// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membermodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    additionalInfo: json['additional_info'] as String,
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('additional_info', instance.additionalInfo);
  return val;
}
