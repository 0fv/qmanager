// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inquirydatemodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InquireDate _$InquireDateFromJson(Map<String, dynamic> json) {
  return InquireDate(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  )
    ..type = json['type'] as String
    ..vdate = json['vdate'] as bool
    ..vtime = json['vtime'] as bool;
}

Map<String, dynamic> _$InquireDateToJson(InquireDate instance) =>
    <String, dynamic>{
      'type': instance.type,
      'date': instance.date?.toIso8601String(),
      'vdate': instance.vdate,
      'vtime': instance.vtime,
    };
