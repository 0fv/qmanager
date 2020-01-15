import 'package:qmanager/modules/choicemodule.dart';
import 'package:qmanager/modules/commentmodule.dart';
import 'package:qmanager/modules/inquirydatemodule.dart';

abstract class AnswerCell {
  static List<AnswerCell> fromJson(var json) {
    List<AnswerCell> l = <AnswerCell>[];
    if (json == null){
      return null;
    }
    for (var j in json) {
      String type = j["type"];
      switch (type) {
        case "choice":
          l.add(Choice.fromJson(j));
          break;
        case "date":
          l.add(InquireDate.fromJson(j));
          break;
        case "comment":
          l.add(Comment.fromJosn(j));
          break;
      }
    }
    return null;
  }

  toJson();
}
