// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    comment: json['comment'] as String,
  )
    ..type = json['type'] as String
    ..line = json['line'] as int
    ..limit = json['limit'] as int
    ..empty = json['empty'] as bool;
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'type': instance.type,
      'comment': instance.comment,
      'line': instance.line,
      'limit': instance.limit,
      'empty': instance.empty,
    };
