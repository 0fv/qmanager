// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questioncellmodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionCell _$QuestionCellFromJson(Map<String, dynamic> json) {
  return QuestionCell(
    title: json['title'] as String,
    answerCells: AnswerCell.fromJson(json['answer_cells']),
  )..mustAnswer = json['must_answer'] as int;
}

Map<String, dynamic> _$QuestionCellToJson(QuestionCell instance) =>
    <String, dynamic>{
      'title': instance.title,
      'answer_cells': instance.answerCells?.map((e) => e?.toJson())?.toList(),
      'must_answer': instance.mustAnswer,
    };
