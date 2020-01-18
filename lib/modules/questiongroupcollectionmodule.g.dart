// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questiongroupcollectionmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionGroupCollection _$QuestionGroupCollectionFromJson(
    Map<String, dynamic> json) {
  return QuestionGroupCollection(
    id: json['id'] as String,
    title: json['title'] as String,
    classification: json['classification'] as String,
    createdAccount: json['created_account'] as String,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    editedAccount: json['edited_accout'] as String,
    editedTime: json['edited_time'] == null
        ? null
        : DateTime.parse(json['edited_time'] as String),
    questionCells: (json['question_cells'] as List)
        ?.map((e) =>
            e == null ? null : QuestionCell.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionGroupCollectionToJson(
    QuestionGroupCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('classification', instance.classification);
  writeNotNull('created_time', instance.createdTime?.toIso8601String());
  writeNotNull('created_account', instance.createdAccount);
  writeNotNull('edited_accout', instance.editedAccount);
  writeNotNull('edited_time', instance.editedTime?.toIso8601String());
  writeNotNull('question_cells',
      instance.questionCells?.map((e) => e?.toJson())?.toList());
  return val;
}
