import 'package:qmanager/modules/questioncellmodule.dart';

class QuestionGroup {
  String title;
  List<QuestionCell> questionCells;
  QuestionGroup({this.title, this.questionCells});

  QuestionGroup.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        questionCells = json["question_cells"] != null
            ? List<QuestionCell>.from(json["question_cells"])
            : null;

  Map<String, dynamic> toJson() =>
      {"title": title, "question_cells": questionCells};
}
