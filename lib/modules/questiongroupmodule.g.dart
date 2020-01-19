// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questiongroupmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionGroup _$QuestionGroupFromJson(Map<String, dynamic> json) {
  return QuestionGroup(
    title: json['title'] as String,
    questionCells: (json['question_cells'] as List)
        ?.map((e) =>
            e == null ? null : QuestionCell.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestionGroupToJson(QuestionGroup instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('question_cells',
      instance.questionCells?.map((e) => e?.toJson())?.toList());
  return val;
}
