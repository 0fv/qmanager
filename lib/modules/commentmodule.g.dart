// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    comment: json['comment'] as String,
  )..type = json['type'] as String;
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'type': instance.type,
      'comment': instance.comment,
    };
