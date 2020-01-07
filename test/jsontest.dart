import 'package:qmanager/modules/questioncellmodule.dart';

main() {
  var value = {
    "title": "title",
    "answer_cells": [
      {"type": "date", "date": "1995-04-04"},
      {"type": "comment", "comment": ""},
      {
        "type": "choice",
        "choice": {"nmm": true},
        "is_multi": false
      }
    ]
  };
  QuestionCell questionCell = QuestionCell.fromJson(value);
  print(questionCell.toJson());
}
