// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membergroupmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberGroup _$MemberGroupFromJson(Map<String, dynamic> json) {
  return MemberGroup(
    id: json['id'] as String,
    groupName: json['group_name'] as String,
    createdAccount: json['created_account'] as String,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    editedAccount: json['edited_account'] as String,
    editedTime: json['edited_time'] == null
        ? null
        : DateTime.parse(json['edited_time'] as String),
  );
}

Map<String, dynamic> _$MemberGroupToJson(MemberGroup instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('group_name', instance.groupName);
  writeNotNull('created_time', instance.createdTime?.toIso8601String());
  writeNotNull('created_account', instance.createdAccount);
  writeNotNull('edited_account', instance.editedAccount);
  writeNotNull('edited_time', instance.editedTime?.toIso8601String());
  return val;
}
